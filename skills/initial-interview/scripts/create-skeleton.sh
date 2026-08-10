#!/usr/bin/env bash
# Create the full interview phase folder skeleton inside an application folder.
# Usage: create-skeleton.sh "<path-to-application-folder>"

set -euo pipefail

APP_DIR="${1:?Usage: create-skeleton.sh <application-folder-path>}"

if [[ ! -d "$APP_DIR" ]]; then
  echo "Error: directory does not exist: $APP_DIR" >&2
  exit 1
fi

PHASES=(
  "0 - Email"
  "1 - Application"
  "2 - 1st Interview"
  "3 - 2nd Interview"
  "4 - 3rd Interview"
  "5 - 4th Interview"
  "6 - Post-Interview Process"
  "7 - Offer"
  "8 - Onboarding"
  "9 - Relocation"
  "10 - Yearly Reviews"
  "11 - Internal Job Applications"
  "12 - Issues"
  "13 - Resignation"
)

for phase in "${PHASES[@]}"; do
  mkdir -p "$APP_DIR/$phase"
done

echo "Created interview phase skeleton in: $APP_DIR"
