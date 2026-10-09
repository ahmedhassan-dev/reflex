#!/usr/bin/env bash
set -e

# Reflex Monorepo Quality & Test Validation Script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Pin strictly to project's local FVM Flutter SDK (Flutter 3.47.6 / Dart 3.13.5)
export PATH="$DIR/.fvm/flutter_sdk/bin:$HOME/.pub-cache/bin:$PATH"

echo "=========================================="
echo "   REFLEX QUALITY & TEST RUNNER (FVM)"
echo "   Flutter: $(flutter --version | head -n 1)"
echo "   Dart:    $(dart --version)"
echo "=========================================="

echo "--> 1. Analyzing reflex_client..."
cd "$DIR/reflex_client"
dart analyze

echo "--> 2. Analyzing reflex_server..."
cd "$DIR/reflex_server"
dart analyze

echo "--> 3. Analyzing reflex_flutter..."
cd "$DIR/reflex_flutter"
flutter analyze

echo "--> 4. Running Serverpod server tests..."
cd "$DIR/reflex_server"
dart test

echo "--> 5. Running Flutter app tests..."
cd "$DIR/reflex_flutter"
flutter test

echo "=========================================="
echo "   ✅ ALL REFLEX CHECKS PASSED!"
echo "=========================================="
