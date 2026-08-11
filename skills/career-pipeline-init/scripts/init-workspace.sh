#!/usr/bin/env bash
# Scaffold a job-search workspace from the plugin template/.
# Usage: init-workspace.sh [--force] [target-dir]
#
# Default target is cwd. Does not copy skills/rules (plugin-owned).
# Does not create .career-pipeline.yml (user copies from the example).

set -euo pipefail

FORCE=0
TARGET=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      FORCE=1
      shift
      ;;
    -*)
      echo "Unknown option: $1" >&2
      echo "Usage: init-workspace.sh [--force] [target-dir]" >&2
      exit 1
      ;;
    *)
      TARGET="$1"
      shift
      ;;
  esac
done

TARGET="${TARGET:-.}"
mkdir -p "$TARGET"
TARGET="$(cd "$TARGET" && pwd)"

PLUGIN_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
TEMPLATE="$PLUGIN_ROOT/template"

if [[ ! -d "$TEMPLATE" ]]; then
  echo "Error: template/ not found next to plugin skills at: $PLUGIN_ROOT" >&2
  exit 1
fi

is_plugin_repo() {
  local root="$1"
  [[ -f "$root/.cursor-plugin/plugin.json" ]] \
    && [[ -d "$root/skills" ]] \
    && [[ -d "$root/template" ]] \
    && grep -q '"name"[[:space:]]*:[[:space:]]*"career-pipeline"' "$root/.cursor-plugin/plugin.json" 2>/dev/null
}

is_already_scaffold() {
  local root="$1"
  if [[ -f "$root/.career-pipeline.yml" ]]; then
    return 0
  fi
  [[ -d "$root/design" && -d "$root/leads" && -d "$root/submissions" ]] \
    && [[ -f "$root/.career-pipeline.yml.example" || -f "$root/docs/getting-started.md" ]]
}

is_effectively_empty() {
  local root="$1"
  local entries=()
  local e
  shopt -s nullglob dotglob
  entries=("$root"/*)
  shopt -u nullglob dotglob
  for e in "${entries[@]+"${entries[@]}"}"; do
    local base
    base="$(basename "$e")"
    if [[ "$base" == "." || "$base" == ".." ]]; then
      continue
    fi
    if [[ "$base" == ".git" ]]; then
      continue
    fi
    return 1
  done
  return 0
}

if is_plugin_repo "$TARGET"; then
  echo "Error: refusing to init inside the career-pipeline plugin repo itself." >&2
  echo "Open an empty job-search folder (or create one), then run init there." >&2
  exit 1
fi

if is_already_scaffold "$TARGET"; then
  echo "Error: this folder already looks like a career-pipeline workspace." >&2
  echo "Refusing to overwrite. Use a new empty folder." >&2
  exit 1
fi

if ! is_effectively_empty "$TARGET"; then
  if [[ "$FORCE" -ne 1 ]]; then
    echo "Error: target is not empty: $TARGET" >&2
    echo "Happy path: use an empty folder (a bare .git dir is OK)." >&2
    echo "To proceed anyway after an explicit override, re-run with --force." >&2
    exit 1
  fi
  echo "Warning: target is not empty; --force set, continuing." >&2
fi

copy_item() {
  local name="$1"
  local src="$TEMPLATE/$name"
  local dest="$TARGET/$name"
  if [[ ! -e "$src" ]]; then
    echo "Error: missing template item: $src" >&2
    exit 1
  fi
  if [[ -e "$dest" ]]; then
    echo "Error: destination already exists: $dest" >&2
    exit 1
  fi
  cp -R "$src" "$dest"
}

# Consumer payload only — never skills/rules
for item in design leads submissions docs AGENTS.md README.md; do
  copy_item "$item"
done

# Example config only (no live .career-pipeline.yml)
if [[ -f "$TEMPLATE/.career-pipeline.yml.example" ]]; then
  cp "$TEMPLATE/.career-pipeline.yml.example" "$TARGET/.career-pipeline.yml.example"
elif [[ -f "$PLUGIN_ROOT/.career-pipeline.yml.example" ]]; then
  # Prefer template copy; fall back to plugin root example with workspace schema URL
  cp "$PLUGIN_ROOT/.career-pipeline.yml.example" "$TARGET/.career-pipeline.yml.example"
else
  echo "Error: no .career-pipeline.yml.example found in template or plugin root" >&2
  exit 1
fi

# Ensure archive placeholder exists
mkdir -p "$TARGET/submissions/.archive"
mkdir -p "$TARGET/design/exports"
mkdir -p "$TARGET/leads"

# Drop any accidental .cursor vendoring if present in older templates
rm -rf "$TARGET/.cursor"

echo "Initialized career-pipeline workspace at: $TARGET"
echo "Next: copy .career-pipeline.yml.example → .career-pipeline.yml and edit it."
