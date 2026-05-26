#!/usr/bin/env bash
# release-mcworld.sh - translated/ 内の .mcworld を GitHub Release にアップロード
#
# Usage:
#   ./scripts/release-mcworld.sh <version> [--dry-run]
#
# Examples:
#   ./scripts/release-mcworld.sh v3.0.0              # 新規リリース作成＋全ファイルアップロード
#   ./scripts/release-mcworld.sh v3.0.0 --dry-run    # アップロード内容のプレビューのみ
#
# 動作:
#   1. translated/ 内の全 .mcworld を asset-names.tsv でリネーム
#   2. GitHub Release を作成（既存なら追加アップロード）
#   3. リリースノートを自動生成

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TRANSLATED_DIR="${PROJECT_DIR}/translated"
MAPPING_FILE="${SCRIPT_DIR}/asset-names.tsv"
REPO="0x48lab/minecraft-edu-ja"

# --- Args ---
VERSION="${1:-}"
DRY_RUN=false
if [[ "${2:-}" == "--dry-run" ]]; then
  DRY_RUN=true
fi

if [[ -z "$VERSION" ]]; then
  echo "Usage: $0 <version> [--dry-run]"
  echo "  e.g.: $0 v3.0.0"
  exit 1
fi

# --- Resolve asset name for a file ---
# Uses asset-names.tsv for explicit mappings, falls back to auto-conversion
resolve_asset_name() {
  local stem="${1%.mcworld}"

  # Look up in TSV (awk for exact match on first field)
  local mapped
  mapped=$(awk -F'\t' -v key="$stem" '$1 == key { print $2; exit }' "$MAPPING_FILE")

  if [[ -n "$mapped" ]]; then
    echo "${mapped}.mcworld"
    return
  fi

  # Auto-convert: remove ' : & -, replace spaces with dots, collapse dots
  local safe
  safe=$(echo "$stem" | sed "s/[':&-]//g; s/ /./g; s/\.\.*/./g; s/^\\.//; s/\\.$//" )
  echo "${safe}.mcworld"
}

# --- Collect files ---
echo "==> Preparing release ${VERSION} for ${REPO}"
echo ""

UPLOAD_ARGS=""
WORLD_LIST=""
COUNT=0
STAGING_DIR=$(mktemp -d)
trap "rm -rf '$STAGING_DIR'" EXIT

for mcworld in "${TRANSLATED_DIR}"/*.mcworld; do
  [[ ! -f "$mcworld" ]] && continue
  bname="$(basename "$mcworld")"
  asset_name=$(resolve_asset_name "$bname")

  echo "  ${bname}"
  echo "    -> ${asset_name}"

  # Copy with safe name to staging
  cp "$mcworld" "${STAGING_DIR}/${asset_name}"
  UPLOAD_ARGS="${UPLOAD_ARGS}
${STAGING_DIR}/${asset_name}"
  WORLD_LIST="${WORLD_LIST}
- ${bname%.mcworld}"
  COUNT=$((COUNT + 1))
done

echo ""
echo "==> Total: ${COUNT} worlds"
echo ""

if $DRY_RUN; then
  echo "[DRY RUN] Would create release ${VERSION} with ${COUNT} assets."
  echo "[DRY RUN] No changes made."
  exit 0
fi

# --- Generate release notes ---
SORTED_LIST=$(echo "$WORLD_LIST" | sort)
NOTES="## 翻訳済みワールド（全${COUNT}種）
${SORTED_LIST}

## インストール方法
.mcworldファイルをダウンロードしてMinecraft Education Editionで開いてください。"

# --- Create release and upload ---
echo "==> Creating release ${VERSION}..."

# Build upload args array from newline-separated list
UPLOAD_CMD="gh release create ${VERSION} --repo ${REPO} --title '${VERSION} - 全${COUNT}ワールド日本語翻訳' --notes-file -"
while IFS= read -r asset_path; do
  [[ -z "$asset_path" ]] && continue
  UPLOAD_CMD="${UPLOAD_CMD} '${asset_path}'"
done <<< "$UPLOAD_ARGS"

echo "$NOTES" | eval "$UPLOAD_CMD"

echo ""
echo "==> Done! https://github.com/${REPO}/releases/tag/${VERSION}"
