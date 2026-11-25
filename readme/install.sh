#!/usr/bin/env bash
# 粒子跃迁 ENERGY DRIFT —— 一键安装脚本
# 本作品运行时零依赖，脚本仅做本地预览环境检查

set -e

echo "=========================================="
echo "  粒子跃迁 ENERGY DRIFT · 环境安装检查"
echo "=========================================="

PROJECT_DIR="$(cd "$(dirname "$0")/../project" && pwd)"

if [ ! -f "$PROJECT_DIR/index.html" ]; then
  echo "[错误] 未找到工程文件: $PROJECT_DIR/index.html"
  exit 1
fi
echo "[OK] 工程源码完整: $PROJECT_DIR/index.html"

if command -v python3 >/dev/null 2>&1; then
  PY_VER="$(python3 --version 2>&1)"
  echo "[OK] $PY_VER（用于本地预览服务器）"
else
  echo "[提示] 未检测到 python3，可直接用浏览器打开 project/index.html 运行"
fi

echo ""
echo "安装检查完成，零第三方依赖，无需下载任何组件。"
echo "启动方式: bash readme/start.sh"
