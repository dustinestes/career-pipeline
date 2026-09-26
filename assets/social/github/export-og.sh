#!/usr/bin/env bash
# Capture Career Pipeline OG brand card as a PNG.
# Requires: google-chrome (or chromium).
#
# Usage (from this directory or repo root):
#   bash assets/social/github/export-og.sh          # dark → career-pipeline-og.png
#   bash assets/social/github/export-og.sh light    # light → career-pipeline-og-light.png
#   bash assets/social/github/export-og.sh both
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
THEME="${1:-dark}"
CHROME="${CHROME:-$(command -v google-chrome || command -v chromium || true)}"
STEM="career-pipeline-og"
HTML="file://${DIR}/${STEM}.html"
EXPORT_DIR="${DIR}/export"

if [[ -z "$CHROME" ]]; then
  echo "error: google-chrome or chromium not found" >&2
  exit 1
fi

if [[ ! -f "${DIR}/${STEM}.html" ]]; then
  echo "error: missing ${DIR}/${STEM}.html" >&2
  exit 1
fi

capture() {
  local theme="$1"
  local out="$EXPORT_DIR/slide-1-${theme}.png"
  local dest
  if [[ "$theme" == "dark" ]]; then
    dest="${DIR}/${STEM}.png"
  else
    dest="${DIR}/${STEM}-light.png"
  fi

  echo "Capturing Career Pipeline brand card (${theme})…"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --no-first-run \
    --window-size=1280,640 \
    --virtual-time-budget=4000 \
    --screenshot="$out" \
    "${HTML}?slide=1&theme=${theme}" >/dev/null 2>&1

  cp "$out" "$dest"
  echo "  wrote ${out}"
  echo "  wrote ${dest}"
}

mkdir -p "$EXPORT_DIR"

case "$THEME" in
  dark|light)
    capture "$THEME"
    ;;
  both)
    capture dark
    capture light
    ;;
  *)
    echo "usage: $0 [dark|light|both]" >&2
    exit 1
    ;;
esac

echo "Done."
