#!/bin/bash
testNewTspFrontend_testCase1_check_scripts() {
  local package_json="$1"
  local scripts=("build:frontend" "serve" "test:frontend")
  local all_scripts_found=true

  for script in "${scripts[@]}"; do
    if grep -q "\"$script\"" "$package_json"; then
      echo "✅ Script '$script' found."
    else
      echo "❌ Script '$script' not found."
      all_scripts_found=false
    fi
  done

  if $all_scripts_found; then
    return 0
  else
    return 1
  fi
}