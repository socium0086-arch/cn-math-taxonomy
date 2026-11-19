#!/usr/bin/env bash
# Build a static site tree suitable for GitHub Pages (project site or user site).
# Usage:
#   ./scripts/prepare-gh-pages.sh [OUT_DIR]
# Env:
#   PAGES_ORIGIN  Canonical origin, e.g. https://user.github.io/cn-math-taxonomy
#   HTML_SUFFIX=1 Use .html in canonical/sitemap (needed for GitHub project Pages)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${1:-${TMPDIR:-/tmp}/cn-math-gh-pages-dist}"
ORIGIN="${PAGES_ORIGIN:-https://socium0086-arch.github.io/cn-math-taxonomy}"

rm -rf "$OUT"
mkdir -p "$OUT/data"

cp "$ROOT/index.html" "$ROOT/sw.js" "$ROOT/manifest.webmanifest" "$OUT/"
[[ -f "$ROOT/.nojekyll" ]] && cp "$ROOT/.nojekyll" "$OUT/"
cp -a "$ROOT/assets" "$OUT/"
cp -a "$ROOT/explore" "$OUT/"
cp -a "$ROOT/diagnose" "$OUT/"
cp -a "$ROOT/children" "$OUT/"
cp -a "$ROOT/goods" "$OUT/"
cp -a "$ROOT/wrongbook" "$OUT/"
rm -f "$OUT/diagnose/README.md"

cp "$ROOT/data/topics.json" \
   "$ROOT/data/dependencies.json" \
   "$ROOT/data/cn-curriculum-standards.json" \
   "$ROOT/data/questions.json" \
   "$ROOT/data/id-aliases.json" \
   "$OUT/data/"

GEN_ARGS=(--out "$OUT" --origin "$ORIGIN")
if [[ "${HTML_SUFFIX:-1}" == "1" ]]; then
  GEN_ARGS+=(--html-suffix)
fi
node "$ROOT/scripts/gen-kp-pages.mjs" "${GEN_ARGS[@]}"

echo "Prepared $(du -sh "$OUT" | awk '{print $1}') at $OUT"
echo "Origin: $ORIGIN"
