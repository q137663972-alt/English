#!/usr/bin/env bash
# 同步 Web 源码到 Android 壳的 assets/
#
# 用法：
#   ./sync-assets.sh            # 体检：列出每个项目源文件与壳 assets 的差异（不修改）
#   ./sync-assets.sh --apply    # 实际同步（覆盖壳里的旧文件，补齐缺失文件）
#
# 规则：源文件为唯一事实来源，壳 assets 一律以源为准。
# 若壳里有源文件没有的多余文件，只提示不删除（可能是壳专用资源）。

set -uo pipefail
APPLY=0
[ "${1:-}" = "--apply" ] && APPLY=1

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

# 项目目录 : 该项目的 Android 壳目录列表
PROJECTS=(
  "chinese:chinese/chinese-universal"
  ".:android-universal"
  "math:math/math-universal"
)

# 需要同步的相对路径（相对项目根目录）
SYNC_PATHS=(
  "index.html"
  "css/style.css"
)

js_dir() { [ -d "$1/js" ] && echo "$1/js"; }

total_ok=0; total_fix=0; total_miss=0

for entry in "${PROJECTS[@]}"; do
  proj="${entry%%:*}"; shells="${entry#*:}"
  proj_dir="$ROOT/$proj"
  [ -d "$proj_dir" ] || { echo "跳过（目录不存在）：$proj"; continue; }

  echo ""
  echo "════════ 项目：$proj ════════"

  # 收集待同步文件清单
  files=()
  for p in "${SYNC_PATHS[@]}"; do
    [ -f "$proj_dir/$p" ] && files+=("$p")
  done
  if [ -d "$proj_dir/js" ]; then
    while IFS= read -r f; do files+=("js/$(basename "$f")"); done < <(find "$proj_dir/js" -maxdepth 1 -name '*.js' -type f | sort)
  fi
  if [ -d "$proj_dir/img" ]; then
    while IFS= read -r f; do files+=("img/$(basename "$f")"); done < <(find "$proj_dir/img" -maxdepth 1 -name '*.webp' -type f | sort)
  fi
  [ ${#files[@]} -eq 0 ] && { echo "  无源文件，跳过"; continue; }

  for sh in $shells; do
    sh_assets="$ROOT/$sh/app/src/main/assets"
    [ -d "$sh_assets" ] || { echo "  ⚠ 壳目录不存在：$sh"; continue; }

    echo "  ── 壳：$sh"
    ok=0; fix=0; miss=0
    for f in "${files[@]}"; do
      src="$proj_dir/$f"; dst="$sh_assets/$f"
      if [ ! -f "$dst" ]; then
        echo "     ➕ 缺失  $f"
        miss=$((miss+1))
        if [ $APPLY -eq 1 ]; then mkdir -p "$(dirname "$dst")"; cp -f "$src" "$dst"; fi
      elif ! cmp -s "$src" "$dst"; then
        echo "     🔄 过期  $f  (源 $(stat -c%s "$src")B / 壳 $(stat -c%s "$dst")B)"
        fix=$((fix+1))
        if [ $APPLY -eq 1 ]; then cp -f "$src" "$dst"; fi
      else
        ok=$((ok+1))
      fi
    done
    # 壳里有、源里没有的文件：只提示
    while IFS= read -r extra; do
      rel="${extra#$sh_assets/}"
      case "$rel" in
        js/*) grep -Fxq "$rel" <(printf '%s\n' "${files[@]}") || echo "     ℹ 仅壳内有  $rel" ;;
        img/*) grep -Fxq "$rel" <(printf '%s\n' "${files[@]}") || echo "     ℹ 仅壳内有  $rel" ;;
      esac
    done < <(find "$sh_assets/js" -maxdepth 1 -name '*.js' -type f 2>/dev/null; find "$sh_assets/img" -maxdepth 1 -name '*.webp' -type f 2>/dev/null)

    [ $APPLY -eq 1 ] && echo "     已同步：$((fix+miss)) 个（新增 $miss / 更新 $fix），一致 $ok"
    total_ok=$((total_ok+ok)); total_fix=$((total_fix+fix)); total_miss=$((total_miss+miss))
  done
done

echo ""
echo "──────── 汇总 ────────"
echo "  一致 $total_ok  ·  过期 $total_fix  ·  缺失 $total_miss"
if [ $APPLY -eq 1 ]; then
  echo "  ✅ 同步完成"
else
  echo "  这是体检模式，未修改任何文件。要实际同步请运行：$0 --apply"
fi
