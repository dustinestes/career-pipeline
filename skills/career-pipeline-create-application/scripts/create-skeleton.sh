#!/usr/bin/env bash
# Create email/ and application/ under a submission folder.
# Usage: create-skeleton.sh "<path-to-application-folder>"

set -euo pipefail

APP_DIR="${1:?Usage: create-skeleton.sh <application-folder-path>}"

mkdir -p "$APP_DIR"
mkdir -p "$APP_DIR/email" "$APP_DIR/application"

echo "Created skeleton (email/, application/) in: $APP_DIR"
