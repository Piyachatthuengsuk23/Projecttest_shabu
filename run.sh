#!/usr/bin/env bash
set -e
mkdir -p results
echo "Running Robot tests (Unix/macOS/Linux)..."
if command -v python >/dev/null 2>&1; then
  python -m robot -d results tests || robot -d results tests
else
  robot -d results tests
fi
echo ""
echo "รายงานถูกสร้างที่โฟลเดอร์ results (report.html, log.html, output.xml)"
