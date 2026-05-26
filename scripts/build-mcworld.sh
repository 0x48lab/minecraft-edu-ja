#!/bin/bash
# build-mcworld.sh - Translate and rebuild .mcworld files
# Usage: ./scripts/build-mcworld.sh <input.mcworld> [output.mcworld]
#
# This script:
# 1. Extracts the .mcworld (ZIP)
# 2. Adds Japanese .lang files
# 3. Replaces MakeCode tutorial URLs with translated versions
# 4. Repackages into a new .mcworld

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
GITHUB_ORG="0x48lab"
GITHUB_REPO="minecraft-edu-ja"

# --- URL mapping ---
# Original -> Translated tutorial path pairs (one per line: original|translated)
URL_MAPPINGS="
fountainstudios/aimakecodemarkdown|${GITHUB_ORG}/${GITHUB_REPO}
fountainstudios/AICustomBlocks|${GITHUB_ORG}/${GITHUB_REPO}-blocks
"

# --- Args ---
INPUT_MCWORLD="$1"
OUTPUT_MCWORLD="${2:-}"

if [[ -z "$INPUT_MCWORLD" ]]; then
  echo "Usage: $0 <input.mcworld> [output.mcworld]"
  exit 1
fi

if [[ -z "$OUTPUT_MCWORLD" ]]; then
  OUTPUT_MCWORLD="${PROJECT_DIR}/translated/$(basename "$INPUT_MCWORLD")"
fi

# --- Work directory ---
WORK_DIR=$(mktemp -d)
trap "rm -rf '$WORK_DIR'" EXIT

echo "==> Extracting: $INPUT_MCWORLD"
unzip -q "$INPUT_MCWORLD" -d "$WORK_DIR"

# --- Derive lesson ID from levelname.txt ---
if [[ -f "$WORK_DIR/levelname.txt" ]]; then
  LESSON_ID=$(cat "$WORK_DIR/levelname.txt" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
else
  LESSON_ID=$(basename "$INPUT_MCWORLD" .mcworld | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
fi
echo "==> Lesson ID: $LESSON_ID"

# --- Add Japanese language files ---
echo "==> Adding Japanese language files..."

# Find all languages.json and add ja_JP
find "$WORK_DIR" -name "languages.json" | while read -r lang_file; do
  if ! grep -q "ja_JP" "$lang_file"; then
    # Handle both single-line and multi-line JSON formats
    python3 -c "
import json, sys
with open('$lang_file', 'r') as f:
    langs = json.load(f)
if 'ja_JP' not in langs:
    langs.append('ja_JP')
with open('$lang_file', 'w') as f:
    json.dump(langs, f, indent=2)
    f.write('\n')
"
    echo "    Updated: $lang_file"
  fi
done

# Copy pre-translated ja_JP.lang files (lesson-specific)
# Always overwrite with pre-translated version if available (originals may contain untranslated ja_JP)
find "$WORK_DIR" -name "en_US.lang" | while read -r en_file; do
  ja_file="$(dirname "$en_file")/ja_JP.lang"
  lang_dir="$(dirname "$en_file")"
  rel_path="${lang_dir#$WORK_DIR/}"

  # Look for lesson-specific pre-translated file first, then fallback to generic
  pretranslated="${SCRIPT_DIR}/lang/${LESSON_ID}/${rel_path}/ja_JP.lang"
  if [[ ! -f "$pretranslated" ]]; then
    pretranslated="${SCRIPT_DIR}/lang/${rel_path}/ja_JP.lang"
  fi

  if [[ -f "$pretranslated" ]]; then
    cp "$pretranslated" "$ja_file"
    echo "    Copied pre-translated: $ja_file"
  elif [[ ! -f "$ja_file" ]]; then
    echo "    WARNING: No ja_JP.lang for $rel_path (skipped)"
  fi
done

# --- Translate levelname.txt ---
if [[ -f "$WORK_DIR/levelname.txt" ]]; then
  echo "==> Translating levelname.txt..."
  # levelname is kept as-is for now; override via lang files
fi

# --- Replace MakeCode URLs ---
echo "==> Replacing MakeCode tutorial URLs..."
find "$WORK_DIR" -name "*.mcfunction" | while read -r mcfunc; do
  changed=false
  echo "$URL_MAPPINGS" | while IFS='|' read -r original translated; do
    [[ -z "$original" ]] && continue
    if grep -q "$original" "$mcfunc"; then
      sed -i '' "s|${original}|${translated}|g" "$mcfunc"
      changed=true
    fi
  done
  if $changed; then
    echo "    Updated: $(basename "$(dirname "$mcfunc")")/$(basename "$mcfunc")"
  fi
done

# --- Apply mcfunction text replacements ---
SEDFILE="${SCRIPT_DIR}/lang/${LESSON_ID}/mcfunction-sed.txt"
if [[ -f "$SEDFILE" ]]; then
  echo "==> Applying mcfunction text replacements..."
  find "$WORK_DIR" -name "*.mcfunction" | while read -r mcfunc; do
    if sed -i '' -f "$SEDFILE" "$mcfunc" 2>/dev/null; then
      :
    fi
  done
  echo "    Applied replacements from $SEDFILE"
fi

# --- Repackage ---
echo "==> Repackaging: $OUTPUT_MCWORLD"
mkdir -p "$(dirname "$OUTPUT_MCWORLD")"
(cd "$WORK_DIR" && zip -q -r "$OUTPUT_MCWORLD" .)

echo "==> Done! Output: $OUTPUT_MCWORLD"
