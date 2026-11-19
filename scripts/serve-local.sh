#!/usr/bin/env bash
# Serve the taxonomy web UI locally (generates kp/ pages into a temp tree by default).
# Usage:
#   ./scripts/serve-local.sh [PORT]
# Opens at http://127.0.0.1:PORT/
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${1:-8765}"
DIST="${TMPDIR:-/tmp}/cn-math-local-preview"

export PAGES_ORIGIN="http://127.0.0.1:${PORT}"
export HTML_SUFFIX=1
"$ROOT/scripts/prepare-gh-pages.sh" "$DIST"

cd "$DIST"
echo "Serving $DIST at http://127.0.0.1:${PORT}/"
echo "Try: home /, explore /explore/, diagnose /diagnose/, index /kp/"
exec python3 -m http.server "$PORT" --bind 127.0.0.1
