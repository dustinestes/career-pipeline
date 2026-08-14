#!/usr/bin/env bash
# Toggle local Cursor plugin install for this checkout.
#
#   ./scripts/dev-mode.sh status
#   ./scripts/dev-mode.sh link      # ~/.cursor/plugins/local/career-pipeline-dev
#   ./scripts/dev-mode.sh unlink    # remove career-pipeline-dev (+ legacy career-pipeline if ours)
#
# After link or unlink: reload Cursor.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_ID="career-pipeline-dev"
LEGACY_ID="career-pipeline"
LOCAL_PLUGINS="${HOME}/.cursor/plugins/local"
PLUGIN_LINK="${LOCAL_PLUGINS}/${PLUGIN_ID}"
LEGACY_LINK="${LOCAL_PLUGINS}/${LEGACY_ID}"

cmd="${1:-status}"

resolve_link() {
  local path="$1"
  if [[ -L "$path" ]]; then
    readlink -f "$path" 2>/dev/null || realpath "$path"
  elif [[ -e "$path" ]]; then
    echo "$path"
  else
    echo ""
  fi
}

points_here() {
  local target
  target="$(resolve_link "$1")"
  [[ -n "$target" && "$target" == "$ROOT" ]]
}

status() {
  echo "Plugin checkout: $ROOT"
  if [[ -e "$PLUGIN_LINK" ]]; then
    echo "Developer link:  $PLUGIN_LINK → $(resolve_link "$PLUGIN_LINK")"
    if points_here "$PLUGIN_LINK"; then
      echo "Mode:            linked (career-pipeline-dev → this checkout)"
    else
      echo "Mode:            mixed (career-pipeline-dev points elsewhere)"
    fi
  else
    echo "Developer link:  (missing) $PLUGIN_LINK"
    echo "Mode:            unlinked (no career-pipeline-dev link)"
  fi
  if [[ -e "$LEGACY_LINK" ]]; then
    echo "Legacy link:     $LEGACY_LINK → $(resolve_link "$LEGACY_LINK")"
  fi
}

link() {
  mkdir -p "$LOCAL_PLUGINS"
  ln -sfn "$ROOT" "$PLUGIN_LINK"
  # Prefer -dev id; drop legacy name if it pointed at this checkout
  if points_here "$LEGACY_LINK" || [[ -L "$LEGACY_LINK" && "$(resolve_link "$LEGACY_LINK")" == "$ROOT" ]]; then
    rm -f "$LEGACY_LINK"
    echo "Removed legacy link $LEGACY_LINK (use $PLUGIN_ID)"
  fi
  echo "Linked $PLUGIN_LINK → $ROOT"
  echo "Reload Cursor. Look for Career Pipeline / career-pipeline-dev under Local plugins."
}

unlink() {
  if points_here "$PLUGIN_LINK" || [[ -L "$PLUGIN_LINK" ]]; then
    # Only remove if ours or a symlink (dev helper owns -dev)
    if points_here "$PLUGIN_LINK" || [[ -L "$PLUGIN_LINK" ]]; then
      rm -f "$PLUGIN_LINK"
      echo "Removed $PLUGIN_LINK"
    fi
  else
    echo "No $PLUGIN_LINK to remove"
  fi
  if points_here "$LEGACY_LINK"; then
    rm -f "$LEGACY_LINK"
    echo "Removed legacy $LEGACY_LINK (pointed at this checkout)"
  fi
  echo "Reload Cursor. Then install from Directory or /add-plugin to test without a local -dev symlink."
}

case "$cmd" in
  status) status ;;
  link) link ;;
  unlink) unlink ;;
  *)
    echo "Usage: $0 {status|link|unlink}" >&2
    exit 1
    ;;
esac
