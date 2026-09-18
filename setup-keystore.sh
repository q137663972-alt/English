#!/usr/bin/env bash
# 生成正式发布 keystore（只跑一次，已存在则拒绝覆盖）
#
# 用法：./setup-keystore.sh
#
# ⚠️ keystore 丢了就永远无法覆盖升级 App（只能换 applicationId 当新应用发）。
#    生成后请立即备份：一份加密压缩包放网盘/邮箱草稿，一份放 U 盘，密码另存。
set -euo pipefail

KS_DIR=/workspace/keystore
KS=$KS_DIR/playground-release.jks
PROPS=$KS_DIR/keystore.properties
KT=/root/.sdkman/candidates/java/20.fx-zulu/bin/keytool
[ -x "$KT" ] || KT=$(command -v keytool) || { echo "❌ 找不到 keytool"; exit 1; }

if [ -f "$KS" ]; then
  echo "keystore 已存在，拒绝覆盖：$KS"
  echo "（若确要重建，请先手动删除该文件，并接受「旧版本无法覆盖升级」的后果）"
  exit 0
fi

mkdir -p "$KS_DIR" && chmod 700 "$KS_DIR"

# PKCS12 不支持 store / key 两套密码（keytool 会静默忽略 -keypass），统一用一个
KS_PASS=$(openssl rand -base64 24)

"$KT" -genkeypair -v -keystore "$KS" -storetype PKCS12 \
  -keyalg RSA -keysize 2048 -validity 10950 \
  -alias playground \
  -dname "CN=Playground Apps, OU=App, O=Q-Studio, L=Shenzhen, ST=Guangdong, C=CN" \
  -storepass "$KS_PASS" -keypass "$KS_PASS"

cat > "$PROPS" <<EOF
KS_FILE=$KS
KS_ALIAS=playground
KS_STORE_PASS=$KS_PASS
KS_KEY_PASS=$KS_PASS
EOF
chmod 600 "$KS" "$PROPS"
printf '*\n' > "$KS_DIR/.gitignore"     # 目录自忽略，防止误提交（双保险）

echo ""
echo "✅ keystore：$KS"
echo "✅ 密码文件：$PROPS  (chmod 600)"
echo ""
echo "证书指纹："
/opt/android-sdk/build-tools/34.0.0/apksigner verify --print-certs "$KS" 2>/dev/null \
  || "$KT" -list -v -keystore "$KS" -storepass "$KS_PASS" 2>/dev/null | grep -i "SHA256\|指纹" || true
echo ""
echo "⚠️  立刻备份：加密压缩包一份放网盘/邮箱草稿，一份放 U 盘，密码另存。"
echo "   丢了这把钥匙 = 以后无法覆盖升级，只能换包名重新发。"
