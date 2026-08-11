#!/usr/bin/env bash
# Hard-delete a submission folder after confirmation is handled by the agent.
# Usage: delete-submission.sh "<company>" "<job title>"

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

COMPANY="${1:?Usage: delete-submission.sh <company> <job title>}"
JOB_TITLE="${2:?Usage: delete-submission.sh <company> <job title>}"

SRC="$SUBMISSIONS/$COMPANY/$JOB_TITLE"

if [[ ! -d "$SRC" ]]; then
  echo "Error: source not found: $SRC" >&2
  exit 1
fi

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
  git -C "$REPO_ROOT" rm -r "$SRC"
else
  rm -rf "$SRC"
fi

COMPANY_DIR="$SUBMISSIONS/$COMPANY"
if [[ -d "$COMPANY_DIR" ]]; then
  shopt -s nullglob
  remaining=("$COMPANY_DIR"/*)
  shopt -u nullglob
  if [[ ${#remaining[@]} -eq 0 ]]; then
    if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree &>/dev/null; then
      git -C "$REPO_ROOT" rmdir "$COMPANY_DIR" 2>/dev/null || rmdir "$COMPANY_DIR"
    else
      rmdir "$COMPANY_DIR"
    fi
    echo "Removed empty company folder: $COMPANY_DIR"
  fi
fi

echo "Deleted: $SRC"
