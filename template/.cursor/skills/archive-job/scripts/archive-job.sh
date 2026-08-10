#!/usr/bin/env bash
# Move a closed application to the archive folder.
# Usage: archive-job.sh "<company>" "<job title>" [reason]
#
# Example:
#   archive-job.sh "DoorDash" "Client Platform Engineer III" "Rejected after onsite"

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../../../" && pwd)"
APPLICATIONS="$REPO_ROOT/3 - Applications"
ARCHIVE="$APPLICATIONS/# - Archive"

COMPANY="${1:?Usage: archive-job.sh <company> <job title> [reason]}"
JOB_TITLE="${2:?Usage: archive-job.sh <company> <job title> [reason]}"
REASON="${3:-}"

SRC="$APPLICATIONS/$COMPANY/$JOB_TITLE"
DEST="$ARCHIVE/$COMPANY/$JOB_TITLE"

if [[ ! -d "$SRC" ]]; then
  echo "Error: source not found: $SRC" >&2
  exit 1
fi

if [[ -d "$DEST" ]]; then
  echo "Error: destination already exists: $DEST" >&2
  exit 1
fi

mkdir -p "$ARCHIVE/$COMPANY"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  git -C "$REPO_ROOT" mv "$SRC" "$DEST"
else
  mv "$SRC" "$DEST"
fi

# Remove empty company folder under Applications if no roles remain
COMPANY_DIR="$APPLICATIONS/$COMPANY"
if [[ -d "$COMPANY_DIR" ]]; then
  shopt -s nullglob
  remaining=("$COMPANY_DIR"/*)
  shopt -u nullglob
  if [[ ${#remaining[@]} -eq 0 ]]; then
    rmdir "$COMPANY_DIR"
    echo "Removed empty company folder: $COMPANY_DIR"
  fi
fi

if [[ -n "$REASON" ]]; then
  printf '%s\n' "# Archive notes" "" "$REASON" > "$DEST/notes.md"
  echo "Wrote notes.md"
fi

echo "Archived: $SRC"
echo "       → $DEST"
