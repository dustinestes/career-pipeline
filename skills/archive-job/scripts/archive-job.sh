#!/usr/bin/env bash
# Move a closed application to the archive folder.
# Usage: archive-job.sh "<company>" "<job title>" [reason]
#
# Workspace root is the job-search cwd (or its git toplevel), not the skill
# install path. Optional override: CAREER_PIPELINE_ROOT.
#
# Example:
#   archive-job.sh "DoorDash" "Client Platform Engineer III" "Rejected after onsite"

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
ARCHIVE="$SUBMISSIONS/.archive"

COMPANY="${1:?Usage: archive-job.sh <company> <job title> [reason]}"
JOB_TITLE="${2:?Usage: archive-job.sh <company> <job title> [reason]}"
REASON="${3:-}"

SRC="$SUBMISSIONS/$COMPANY/$JOB_TITLE"
DEST="$ARCHIVE/$COMPANY/$JOB_TITLE"

if [[ ! -d "$SUBMISSIONS" ]]; then
  echo "Error: submissions/ not found under workspace root: $REPO_ROOT" >&2
  echo "Run this script with cwd set to your job-search workspace (or set CAREER_PIPELINE_ROOT)." >&2
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

mkdir -p "$ARCHIVE/$COMPANY"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  git -C "$REPO_ROOT" mv "$SRC" "$DEST"
else
  mv "$SRC" "$DEST"
fi

# Remove empty company folder under submissions if no roles remain
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

if [[ -n "$REASON" ]]; then
  printf '%s\n' "# Archive notes" "" "$REASON" > "$DEST/notes.md"
  echo "Wrote notes.md"
fi

echo "Archived: $SRC"
echo "       → $DEST"
