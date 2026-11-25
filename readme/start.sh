#!/usr/bin/env bash
# 粒子跃迁 ENERGY DRIFT —— 一键启动脚本
# 用法: bash start.sh [端口]   默认端口 8000

set -e

PORT="${1:-8000}"
PROJECT_DIR="$(cd "$(dirname "$0")/../project" && pwd)"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[提示] 未检测到 python3，请直接用浏览器打开: $PROJECT_DIR/index.html"
  exit 1
fi

echo "=========================================="
echo "  粒子跃迁 ENERGY DRIFT · 启动中"
echo "  预览地址: http://localhost:$PORT/"
echo "  按 Ctrl+C 停止"
echo "=========================================="

cd "$PROJECT_DIR"
exec python3 -m http.server "$PORT"
