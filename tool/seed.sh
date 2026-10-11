#!/usr/bin/env bash
set -e

# Reflex Database Seeding Script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Pin strictly to project's local FVM Flutter / Dart SDK
export PATH="$DIR/.fvm/flutter_sdk/bin:$HOME/.pub-cache/bin:$PATH"

echo "=========================================="
echo "   REFLEX DATABASE SEEDER"
echo "=========================================="

cd "$DIR/reflex_server"
dart run bin/seed.dart

echo "=========================================="
echo "   ✅ DATABASE SEEDING COMPLETED!"
echo "=========================================="
