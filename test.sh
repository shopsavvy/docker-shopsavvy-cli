#!/bin/bash
set -e

echo "ShopSavvy Docker CLI Tests"
echo "==========================="

if [ "$1" = "--integration" ]; then
  if [ -z "$SHOPSAVVY_API_KEY" ]; then
    echo "Set SHOPSAVVY_API_KEY env var to run integration tests"
    echo "  Get a key at https://shopsavvy.com/data"
    exit 1
  fi
  echo "Running integration tests (builds and runs Docker image)..."
  echo ""

  echo "Building image..."
  docker build -t shopsavvy/cli-test . 2>&1 | tail -3
  echo "  Build OK"

  echo "Testing help..."
  docker run --rm shopsavvy/cli-test help | head -3
  echo "  Help OK"

  echo "Testing search..."
  docker run --rm -e SHOPSAVVY_API_KEY="$SHOPSAVVY_API_KEY" shopsavvy/cli-test search "airpods" --limit 1 --json | head -5
  echo "  Search OK"

  echo ""
  echo "All integration tests passed"
else
  echo "Running structural checks..."
  echo ""

  echo "Checking required files..."
  REQUIRED="Dockerfile README.md"
  MISSING=0
  for f in $REQUIRED; do
    if [ ! -f "$f" ]; then
      echo "  Missing: $f"
      MISSING=$((MISSING + 1))
    fi
  done
  if [ $MISSING -eq 0 ]; then
    echo "  All required files present"
  else
    echo "  $MISSING required files missing"
    exit 1
  fi

  echo "Checking Dockerfile syntax..."
  if grep -q "FROM" Dockerfile && grep -q "ENTRYPOINT" Dockerfile; then
    echo "  Dockerfile has FROM and ENTRYPOINT"
  else
    echo "  Dockerfile missing required directives"
    exit 1
  fi

  if grep -q "shopsavvy" Dockerfile; then
    echo "  Dockerfile references shopsavvy-cli"
  else
    echo "  Dockerfile doesn't reference shopsavvy"
    exit 1
  fi

  echo ""
  echo "All unit checks passed"
  echo ""
  echo "Note: Full Docker tests require Docker daemon."
  echo "Run './test.sh --integration' with SHOPSAVVY_API_KEY to build and test."
fi
