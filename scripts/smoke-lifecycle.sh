#!/usr/bin/env bash
# Maintainer smoke test for career-pipeline (#7).
# Proves: init scaffold, submission lifecycle scripts, Chrome+pdfunite PDF export,
# and that local plugin install exposes expected skills.
#
# Usage:
#   ./scripts/smoke-lifecycle.sh           # temp dir, cleaned on success
#   KEEP=1 ./scripts/smoke-lifecycle.sh    # leave WORK_DIR for inspection
#   WORK_DIR=/tmp/cp-smoke ./scripts/smoke-lifecycle.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KEEP="${KEEP:-0}"
WORK_DIR="${WORK_DIR:-}"
CREATED_TMP=0

if [[ -z "$WORK_DIR" ]]; then
  WORK_DIR="$(mktemp -d /tmp/career-pipeline-smoke.XXXXXX)"
  CREATED_TMP=1
fi

cleanup() {
  local code=$?
  if [[ "$KEEP" != "1" && "$CREATED_TMP" -eq 1 && -d "$WORK_DIR" ]]; then
    rm -rf "$WORK_DIR"
  elif [[ "$KEEP" == "1" ]]; then
    echo "KEEP=1: workspace left at $WORK_DIR"
  fi
  exit "$code"
}
trap cleanup EXIT

echo "==> Plugin root: $ROOT"
echo "==> Smoke workspace: $WORK_DIR"

fail() { echo "FAIL: $*" >&2; exit 1; }
pass() { echo "PASS: $*"; }

# --- 1. Local plugin skills visible ---
PLUGIN_LINK=""
for name in career-pipeline-dev career-pipeline; do
  if [[ -e "$HOME/.cursor/plugins/local/$name" ]]; then
    PLUGIN_LINK="$(readlink -f "$HOME/.cursor/plugins/local/$name" 2>/dev/null || realpath "$HOME/.cursor/plugins/local/$name")"
    break
  fi
done

EXPECTED_SKILLS=(
  career-pipeline-init
  career-pipeline-source-leads
  career-pipeline-archive-lead
  career-pipeline-analyze-job
  career-pipeline-create-application
  career-pipeline-create-interview-prep
  career-pipeline-archive-submission
  career-pipeline-delete-submission
)

if [[ -n "$PLUGIN_LINK" ]]; then
  echo "==> Local plugin link → $PLUGIN_LINK"
  [[ "$PLUGIN_LINK" == "$ROOT" ]] || echo "WARN: plugin link does not point at this checkout ($ROOT)"
  for s in "${EXPECTED_SKILLS[@]}"; do
    [[ -f "$PLUGIN_LINK/skills/$s/SKILL.md" ]] || fail "plugin missing skill $s"
  done
  pass "local plugin exposes ${#EXPECTED_SKILLS[@]} skills"
else
  echo "WARN: no ~/.cursor/plugins/local/career-pipeline-dev; checking repo skills/ only"
  echo "      Run ./scripts/dev-mode.sh link for a Cursor-local install."
  for s in "${EXPECTED_SKILLS[@]}"; do
    [[ -f "$ROOT/skills/$s/SKILL.md" ]] || fail "repo missing skill $s"
  done
  pass "repo skills/ present (symlink local plugin to smoke Cursor install)"
fi

# --- 2. Init scaffold ---
mkdir -p "$WORK_DIR"
# init into a subdir that starts empty
WS="$WORK_DIR/job-search"
mkdir -p "$WS"
bash "$ROOT/skills/career-pipeline-init/scripts/init-workspace.sh" "$WS"
[[ -f "$WS/.career-pipeline.yml.example" ]] || fail "missing example yaml after init"
[[ ! -f "$WS/.career-pipeline.yml" ]] || fail "init must not create live yaml"
[[ -d "$WS/design" && -d "$WS/leads" && -d "$WS/submissions" ]] || fail "missing scaffold folders"
[[ ! -d "$WS/.cursor/skills" ]] || fail "init must not vendor skills"
[[ -d "$WS/leads/.archive" ]] || fail "missing leads/.archive"
[[ -f "$WS/docs/skills.md" ]] || fail "missing consumer docs/skills.md"
pass "init scaffold"

cp "$WS/.career-pipeline.yml.example" "$WS/.career-pipeline.yml"
pass "live yaml created from example"

# --- 3. Fake lead + analyze artifact + create-application skeleton ---
COMPANY="SmokeCo"
ROLE="Warehouse Supervisor"
APP="$WS/submissions/$COMPANY/$ROLE"
mkdir -p "$APP"
cat > "$APP/assessment.md" <<'EOF'
# Assessment — SmokeCo / Warehouse Supervisor

**Recommendation:** Proceed (smoke test)

## Fit
Synthetic assessment for career-pipeline smoke-lifecycle.
EOF
pass "analyze-style assessment at role root"

bash "$ROOT/skills/career-pipeline-create-application/scripts/create-skeleton.sh" "$APP"
[[ -d "$APP/email" && -d "$APP/application" ]] || fail "skeleton missing email/ or application/"
mv "$APP/assessment.md" "$APP/application/assessment.md"
pass "create-application skeleton + assessment promoted"

# Interview prep folder on demand
mkdir -p "$APP/interview - 1st"
echo "# Interview prep (smoke)" > "$APP/interview - 1st/interview-prep.md"
pass "create-interview-prep folder shape"

# --- 4. PDF export (Chrome + pdfunite) ---
command -v google-chrome >/dev/null || fail "google-chrome not on PATH"
command -v pdfunite >/dev/null || fail "pdfunite not on PATH (poppler-utils)"

# Working copies of samples (as a user would after choosing samples)
cp "$WS/design/resume_sample_1.html" "$WS/design/resume.html"
cp "$WS/design/cover_letter_sample_1.html" "$WS/design/cover-letter.html"
mkdir -p "$WS/design/exports" "$APP/application"

(
  cd "$WS"
  google-chrome --headless=new --disable-gpu --window-size=816,900 \
    --print-to-pdf="$PWD/design/exports/resume-smoke.pdf" \
    --print-to-pdf-no-header --no-margins \
    "file://$PWD/design/resume.html" \
    >/dev/null 2>&1
  google-chrome --headless=new --disable-gpu --window-size=816,900 \
    --print-to-pdf="$PWD/application-cover-smoke.pdf" \
    --print-to-pdf-no-header --no-margins \
    "file://$PWD/design/cover-letter.html" \
    >/dev/null 2>&1
)
# Move cover into application folder (typical workflow)
mv "$WS/application-cover-smoke.pdf" "$APP/application/cover-letter-smoke.pdf"
cp "$WS/design/exports/resume-smoke.pdf" "$APP/application/resume-smoke.pdf"

[[ -s "$APP/application/cover-letter-smoke.pdf" ]] || fail "cover letter PDF empty/missing"
[[ -s "$APP/application/resume-smoke.pdf" ]] || fail "resume PDF empty/missing"

(
  cd "$APP/application"
  pdfunite cover-letter-smoke.pdf resume-smoke.pdf combined-smoke.pdf
)
[[ -s "$APP/application/combined-smoke.pdf" ]] || fail "combined PDF missing"
pass "Chrome headless + pdfunite PDF export"

# --- 5. Archive submission ---
(
  cd "$WS"
  bash "$ROOT/skills/career-pipeline-archive-submission/scripts/archive-submission.sh" \
    "$COMPANY" "$ROLE" "smoke test archive"
)
[[ -d "$WS/submissions/.archive/$COMPANY/$ROLE" ]] || fail "archive destination missing"
[[ ! -d "$APP" ]] || fail "live submission should be gone after archive"
[[ -f "$WS/submissions/.archive/$COMPANY/$ROLE/notes.md" ]] || fail "archive notes.md missing"
pass "archive-submission"

# --- 6. Archive lead (ignore_companies) ---
mkdir -p "$WS/leads"
echo "# SmokeCo" > "$WS/leads/SmokeCo.md"
(
  cd "$WS"
  bash "$ROOT/skills/career-pipeline-archive-lead/scripts/archive-lead.sh" SmokeCo "smoke ignore"
)
[[ -f "$WS/leads/.archive/SmokeCo.md" ]] || fail "archived lead missing"
grep -q "SmokeCo" "$WS/.career-pipeline.yml" || fail "ignore_companies not updated"
pass "archive-lead + ignore_companies"

echo ""
echo "All smoke checks passed."
