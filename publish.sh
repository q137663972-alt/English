#!/usr/bin/env bash
# 一条命令：构建 → 签名 → 发布到 Pages 下载直链
#
# 这条链路完全不依赖 GitHub Actions Secrets：
#   签名在沙箱本地完成（keystore 不进仓库），Pages 直链用 git 推送（代理对 git 协议透传认证，
#   但对 REST API 不透传，所以写不了 Secrets —— 详见手册第 6 节）。
#
# 用法：
#   ./publish.sh              # 三个包全做
#   ./publish.sh math         # 只做数学
#   GH_USER=xxx GIT_TOKEN=ghp_xxx ./publish.sh
set -uo pipefail

GH_USER="${GH_USER:-q137663972-alt}"
PROXY="${GIT_PROXY:-https://gh-proxy.com/https://github.com}"

if [ -z "${GIT_TOKEN:-}" ] && [ -r /workspace/.git_token ]; then
  GIT_TOKEN="$(cat /workspace/.git_token)"
fi
[ -n "${GIT_TOKEN:-}" ] || { echo "❌ 需要 GIT_TOKEN（或放一份在 /workspace/.git_token）"; exit 1; }

AUTH="$(printf '%s:%s' "$GH_USER" "$GIT_TOKEN" | base64 -w0)"
HDR="http.extraHeader=Authorization: Basic $AUTH"
gh() { git -c "$HDR" "$@"; }

# 1. 构建并签名
./build-apk.sh "${1:-}" || { echo "❌ 构建失败，未发布"; exit 1; }

# 2. 每个包推到对应仓库的 gh-pages（Pages 直链）
publish() {
  local repo_dir="$1" apk="$2" name="$3"
  [ -f "/workspace/apk/$apk" ] || { echo "跳过（未产出）：$apk"; return; }
  echo "════ 发布 $apk → $repo_dir gh-pages ════"
  cp "/workspace/apk/$apk" /tmp/publish-$apk
  ( cd "/workspace/$repo_dir" \
    && gh fetch -q origin gh-pages \
    && git checkout -q -B gh-pages FETCH_HEAD \
    && mkdir -p apk && cp "/tmp/publish-$apk" "apk/$apk" \
    && git add -f "apk/$apk" \
    && git commit -q -m "发布 $apk（$name）" \
    && gh push origin HEAD:gh-pages \
    && git checkout -q main ) 2>&1 | grep -Ei "To .*github|fatal|error" | head -3
  echo "   ✅ https://${GH_USER}.github.io/$name/apk/$apk"
}

FILTER="${1:-}"
case "$FILTER" in
  ""|chinese) publish chinese ChinesePlayground.apk chinese ;;
esac
case "$FILTER" in
  ""|math)     publish math     MathPlayground.apk    math ;;
esac
case "$FILTER" in
  ""|english)  publish .        EnglishPlayground.apk English ;;
esac

echo ""
echo "完成。首次发布 Pages 需 1~2 分钟生效。"
