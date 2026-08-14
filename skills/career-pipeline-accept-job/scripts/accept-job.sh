#!/usr/bin/env bash
# Promote an accepted role from submissions/ into career/ history.
# Usage: accept-job.sh "<company>" "<job title>" [start YYYY-MM]
#
# Workspace root is the job-search cwd (or its git toplevel), not the skill
# install path. Optional override: CAREER_PIPELINE_ROOT.

set -euo pipefail

resolve_workspace_root() {
  if [[ -n "${CAREER_PIPELINE_ROOT:-}" ]]; then
    cd "$CAREER_PIPELINE_ROOT" && pwd
    return
  fi
  if git rev-parse --show-toplevel &>/dev/null; then
    git rev-parse --show-toplevel
    return
  fi
  pwd
}

REPO_ROOT="$(resolve_workspace_root)"
SUBMISSIONS="$REPO_ROOT/submissions"
CAREER="$REPO_ROOT/career"
YAML="$REPO_ROOT/.career-pipeline.yml"

COMPANY="${1:?Usage: accept-job.sh <company> <job title> [start YYYY-MM]}"
JOB_TITLE="${2:?Usage: accept-job.sh <company> <job title> [start YYYY-MM]}"
START="${3:-$(date +%Y-%m)}"

if [[ ! "$START" =~ ^[0-9]{4}-[0-9]{2}$ ]]; then
  echo "Error: start must be YYYY-MM (got: $START)" >&2
  exit 1
fi

SRC="$SUBMISSIONS/$COMPANY/$JOB_TITLE"
DEST="$CAREER/$COMPANY/$JOB_TITLE"

if [[ ! -d "$SUBMISSIONS" ]]; then
  echo "Error: submissions/ not found under workspace root: $REPO_ROOT" >&2
  echo "Run with cwd set to your job-search workspace (or set CAREER_PIPELINE_ROOT)." >&2
  exit 1
fi

if [[ ! -d "$SRC" ]]; then
  echo "Error: source not found: $SRC" >&2
  exit 1
fi

if [[ -d "$DEST" ]]; then
  echo "Error: destination already exists: $DEST" >&2
  exit 1
fi

mkdir -p "$CAREER/$COMPANY"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  git -C "$REPO_ROOT" mv "$SRC" "$DEST"
else
  mv "$SRC" "$DEST"
fi

# Employment-stage skeleton (lowercase single segments; no leading sort numbers)
for stage in offer onboarding relocation reviews issues leaving; do
  mkdir -p "$DEST/$stage"
  if [[ ! -e "$DEST/$stage/.gitkeep" ]] && [[ -z "$(ls -A "$DEST/$stage" 2>/dev/null)" ]]; then
    : > "$DEST/$stage/.gitkeep"
  fi
done

COMPANY_DIR="$SUBMISSIONS/$COMPANY"
if [[ -d "$COMPANY_DIR" ]]; then
  shopt -s nullglob
  remaining=("$COMPANY_DIR"/*)
  shopt -u nullglob
  if [[ ${#remaining[@]} -eq 0 ]]; then
    rmdir "$COMPANY_DIR"
    echo "Removed empty company folder: $COMPANY_DIR"
  fi
fi

# Best-effort: prepend current role to background.experience
if [[ -f "$YAML" ]] && command -v python3 &>/dev/null; then
  python3 - "$YAML" "$COMPANY" "$JOB_TITLE" "$START" <<'PY'
import json
import re
import sys
from pathlib import Path

path = Path(sys.argv[1])
employer = sys.argv[2]
title = sys.argv[3]
start = sys.argv[4]
text = path.read_text()


def yaml_scalar(value: str) -> str:
    if value == "":
        return '""'
    lowered = value.lower()
    if lowered in {"true", "false", "null", "yes", "no", "on", "off"}:
        return json.dumps(value)
    if re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9 ._/'-]*", value) and not any(
        c in value for c in ":#{}[]&*?|>!%@`"
    ):
        return value
    return json.dumps(value)


emp_s = yaml_scalar(employer)
title_s = yaml_scalar(title)

already = False
lines = text.splitlines()
for i, line in enumerate(lines):
    if not re.match(rf"^    - employer:\s*{re.escape(emp_s)}\s*$", line):
        continue
    title_line = lines[i + 1] if i + 1 < len(lines) else ""
    if re.match(rf"^      title:\s*{re.escape(title_s)}\s*$", title_line):
        already = True
        break

if already:
    print(f"background.experience already lists {employer} / {title}")
    sys.exit(0)

text, closed = re.subn(
    r"^([ \t]+end:[ \t]*)(['\"]?)present\2[ \t]*$",
    rf'\1"{start}"',
    text,
    flags=re.MULTILINE,
)

item = (
    f"    - employer: {emp_s}\n"
    f"      title: {title_s}\n"
    f'      start: "{start}"\n'
    f"      end: present\n"
)

out = []
inserted = False
for line in text.splitlines(keepends=True):
    if not inserted and re.match(r"^  experience:\s*\[\s*\]\s*$", line):
        out.append("  experience:\n")
        out.append(item)
        inserted = True
        continue
    out.append(line)
    if not inserted and re.match(r"^  experience:\s*$", line):
        out.append(item)
        inserted = True

if not inserted:
    print(
        "Warning: could not update .career-pipeline.yml; add background.experience manually",
        file=sys.stderr,
    )
    sys.exit(0)

path.write_text("".join(out))
bits = [f"Prepended {employer} / {title} to background.experience (start {start})"]
if closed:
    bits.append(f"closed {closed} prior end: present → {start}")
print("; ".join(bits))
PY
elif [[ -f "$YAML" ]]; then
  echo "Warning: python3 not available; add the role to background.experience manually" >&2
else
  echo "Warning: no .career-pipeline.yml; skipped experience update" >&2
fi

echo "Accepted: $SRC"
echo "       → $DEST"
echo "Stages: offer/ onboarding/ relocation/ reviews/ issues/ leaving/"
