#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspPackageName() {
  echo "📦 Package name test extravaganza! Let's check those names! 🏷️"

  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-pkg-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT

  local tests_run=0
  local tests_passed=0

  # # Test 1: Name with special chars and trailing dash
  # tests_run=$((tests_run + 1))
  # cd "$test_dir"
  # newTsp "ugly_name--123!" --node
  # if [ -d "ugly_name--123" ] &&
  #    jq -e '.name == "ugly-name-123"' ugly_name--123/package.json >/dev/null; then
  #   echo "✅ Trailing dash & special chars handled! 🧹"
  #   tests_passed=$((tests_passed + 1))
  # else
  #   echo "❌ Failed to clean ugly name!"
  # fi

  # Test 2: Uppercase conversion
  # tests_run=$((tests_run + 1))
  # cd "$test_dir"
  # newTsp "MyCOOLProject" --node
  # if [ -d "MyCOOLProject" ] &&
  #    jq -e '.name == "mycoolproject"' MyCOOLProject/package.json >/dev/null; then
  #   echo "✅ Uppercase to lowercase conversion works! ⬇️"
  #   tests_passed=$((tests_passed + 1))
  # else
  #   echo "❌ Uppercase handling failed!"
  # fi

  # Results
  echo "📊 Package name tests: $tests_passed/$tests_run passed!"
  return $((tests_run - tests_passed))
}
