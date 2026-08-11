#!/usr/bin/env bash
# Archive a company lead and append to search.ignore_companies in YAML.
# Usage: archive-lead.sh "<company>" [reason]
#
# Moves leads/<Company>.md → leads/.archive/<Company>.md
# Appends company to .career-pipeline.yml search.ignore_companies when possible.

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
LEADS="$REPO_ROOT/leads"
ARCHIVE="$LEADS/.archive"
YAML="$REPO_ROOT/.career-pipeline.yml"

COMPANY="${1:?Usage: archive-lead.sh <company> [reason]}"
REASON="${2:-}"

SRC="$LEADS/$COMPANY.md"
DEST="$ARCHIVE/$COMPANY.md"

if [[ ! -f "$SRC" ]]; then
  echo "Error: lead file not found: $SRC" >&2
  exit 1
fi

if [[ -e "$DEST" ]]; then
  echo "Error: destination already exists: $DEST" >&2
  exit 1
fi

mkdir -p "$ARCHIVE"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  git -C "$REPO_ROOT" mv "$SRC" "$DEST"
else
  mv "$SRC" "$DEST"
fi

if [[ -n "$REASON" ]]; then
  {
    echo ""
    echo "<!-- archived: $REASON -->"
  } >> "$DEST"
fi

# Best-effort: append to ignore_companies if YAML exists and python3 is available
if [[ -f "$YAML" ]] && command -v python3 &>/dev/null; then
  python3 - "$YAML" "$COMPANY" <<'PY'
import sys
from pathlib import Path

path = Path(sys.argv[1])
company = sys.argv[2]
text = path.read_text()

# If already listed, skip
if f"- {company}" in text or f'- "{company}"' in text or f"- '{company}'" in text:
    print(f"ignore_companies already lists {company}")
    sys.exit(0)

needle = "ignore_companies:"
if needle in text:
    # Insert after the key line
    lines = text.splitlines(keepends=True)
    out = []
    inserted = False
    for i, line in enumerate(lines):
        out.append(line)
        if not inserted and line.strip().startswith("ignore_companies:"):
            # empty list or existing items
            if line.rstrip().endswith(":") or line.strip() == "ignore_companies:":
                out.append(f"    - {company}\n")
                inserted = True
            else:
                # inline empty []
                if "[]" in line:
                    out[-1] = line.replace("[]", f"\n    - {company}\n", 1)
                    inserted = True
    if not inserted:
        # find block and append after last list item under ignore_companies
        out = []
        in_block = False
        for line in lines:
            if line.strip().startswith("ignore_companies:"):
                in_block = True
                out.append(line)
                continue
            if in_block:
                if line.startswith("  ") and line.strip().startswith("- "):
                    out.append(line)
                    continue
                out.append(f"    - {company}\n")
                out.append(line)
                in_block = False
                inserted = True
                continue
            out.append(line)
        if in_block and not inserted:
            out.append(f"    - {company}\n")
            inserted = True
    path.write_text("".join(out))
    print(f"Appended {company} to search.ignore_companies")
else:
    # Insert under search: section
    lines = text.splitlines(keepends=True)
    out = []
    inserted = False
    for i, line in enumerate(lines):
        out.append(line)
        if not inserted and line.startswith("search:"):
            # find a spot after search: — insert ignore_companies near top of search
            # peek ahead: insert right after search:
            out.append(f"  ignore_companies:\n    - {company}\n")
            inserted = True
    if inserted:
        path.write_text("".join(out))
        print(f"Added search.ignore_companies with {company}")
    else:
        print("Warning: could not update .career-pipeline.yml; add ignore_companies manually", file=sys.stderr)
PY
elif [[ -f "$YAML" ]]; then
  echo "Warning: python3 not available; add '$COMPANY' to search.ignore_companies manually" >&2
else
  echo "Warning: no .career-pipeline.yml; skipped ignore_companies update" >&2
fi

echo "Archived lead: $SRC"
echo "            → $DEST"
