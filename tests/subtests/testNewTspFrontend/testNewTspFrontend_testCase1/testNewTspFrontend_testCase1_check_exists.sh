#!/bin/bash
testNewTspFrontend_testCase1_check_exists() {
  local path="$1"
  if [ -e "$path" ]; then
    echo "✅ '$path' exists."
    return 0
  else
    echo "❌ '$path' does not exist."
    return 1
  fi
}