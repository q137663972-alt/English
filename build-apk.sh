#!/usr/bin/env bash
# 本地构建 APK（不改动工作区任何项目文件）
# 做法：把壳工程复制到 /tmp 下的构建沙箱，把 google()/mavenCentral() 换成国内镜像，
#      构建完成后把 APK 拷回 ./apk/。compileSdk 由 ~/.gradle/init.d/compilesdk.gradle 覆盖为 35。
#
# 用法：
#   ./build-apk.sh                # 构建全部 5 个壳
#   ./build-apk.sh chinese        # 只构建名字含 chinese 的壳
set -o pipefail

GRADLE=/opt/gradle-8.2/bin/gradle
SDK=/opt/android-sdk
BUILD=/tmp/apkbuild
OUT=/workspace/apk
KS_PROPS=/workspace/keystore/keystore.properties
APKSIGNER=$SDK/build-tools/34.0.0/apksigner
ZIPALIGN=$SDK/build-tools/34.0.0/zipalign

mkdir -p "$OUT"

# 没有 keystore 就直接退出 —— 绝不能静默产出未签名包（装机会报「安装包没有签名」）
if [ ! -r "$KS_PROPS" ]; then
  echo "❌ 未找到签名配置：$KS_PROPS"
  echo "   先跑 ./setup-keystore.sh 生成正式 keystore，再执行本脚本。"
  exit 1
fi
set -a; . "$KS_PROPS"; set +a

# 项目:壳:输出名
TARGETS=(
  "chinese/chinese-universal:ChinesePlayground"
  "math/math-app:MathPlayground-TV"
  "math/math-phone:MathPlayground-Phone"
  "android-app:EnglishPlayground-TV"
  "android-phone:EnglishPlayground-Phone"
)

FILTER="${1:-}"
ok=0; fail=0

for t in "${TARGETS[@]}"; do
  dir="${t%%:*}"; name="${t#*:}"
  [ -n "$FILTER" ] && [[ "$dir" != *"$FILTER"* ]] && continue
  proj="/workspace/$dir"
  [ -d "$proj" ] || { echo "跳过（不存在）：$dir"; continue; }

  echo ""
  echo "════════ $name  ←  $dir ════════"
  rm -rf "$BUILD/$name"
  mkdir -p "$BUILD"
  cp -r "$proj" "$BUILD/$name"

  # 注入镜像（只在副本里改）
  echo "sdk.dir=$SDK" > "$BUILD/$name/local.properties"
  find "$BUILD/$name" -maxdepth 2 -name 'build.gradle' -o -maxdepth 2 -name 'settings.gradle' | while read -r f; do
    sed -i "s|google()|maven { url 'https://maven.aliyun.com/repository/google' }|g; \
            s|mavenCentral()|maven { url 'https://maven.aliyun.com/repository/public' }|g" "$f"
  done

  ( cd "$BUILD/$name" && $GRADLE assembleRelease --no-daemon --console=plain ) 2>&1 | tail -25

  # 只认 release 目录；app-release-unsigned.apk 排在 app-release.apk 之前（'-' < '.'）
  apk=$(find "$BUILD/$name" -path '*/outputs/apk/release/*' -name '*.apk' | sort | head -1)
  if [ -z "$apk" ]; then
    echo "❌ 未产出 release APK：$name"
    fail=$((fail+1))
    continue
  fi

  # AGP 产物本已 zipalign，这里只校验；万一没对齐才补跑
  aligned="$apk"
  if ! "$ZIPALIGN" -c 4 "$apk" >/dev/null 2>&1; then
    aligned="$BUILD/$name/aligned.apk"
    "$ZIPALIGN" -f -p 4 "$apk" "$aligned"
  fi

  # minSdk 21 → v1 必开（Android 6- 只认 v1）；v2 开；v3 要求 minSdk≥28，关掉
  if "$APKSIGNER" sign --ks "$KS_FILE" --ks-key-alias "$KS_ALIAS" \
       --ks-pass "pass:$KS_STORE_PASS" --key-pass "pass:$KS_KEY_PASS" \
       --min-sdk-version 21 \
       --v1-signing-enabled true --v2-signing-enabled true \
       --v3-signing-enabled false --v4-signing-enabled false \
       --out "$OUT/$name.apk" "$aligned" \
     && "$APKSIGNER" verify "$OUT/$name.apk"; then
    echo "✅ $OUT/$name.apk  ($(du -h "$OUT/$name.apk" | cut -f1)) 已签名"
    ok=$((ok+1))
  else
    echo "❌ 签名失败：$name"
    fail=$((fail+1))
  fi
done

echo ""
echo "完成：成功 $ok 失败 $fail → $OUT"
ls -la "$OUT"
