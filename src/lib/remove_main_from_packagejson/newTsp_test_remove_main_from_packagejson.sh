#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_test_remove_main_from_packagejson() {
  local initial_dir=$(pwd)
  trap 'cd "$initial_dir"' EXIT

  local test_dir=$(mktemp -d -t test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT

  local package_json_path="$test_dir/package.json"

  # Test Case 1: Package.json does not exist
  echo "Test Case 1: Package.json does not exist"
  newTsp_remove_main_from_packagejson "$package_json_path"
  if [[ $? -eq 0 ]]; then
    echo "FAIL: Test Case 1 - Function should fail when package.json does not exist."
    cd "$initial_dir"
    return 1
  else
    echo "PASS: Test Case 1 - Function correctly failed when package.json does not exist."
  fi

  # Test Case 2: Package.json exists, but does not have 'main' key
  echo "Test Case 2: Package.json exists, but does not have 'main' key"
  local original_content='{"name": "test", "version": "1.0.0"}'
  echo "$original_content" >"$package_json_path"
  newTsp_remove_main_from_packagejson "$package_json_path"
  if [[ $? -eq 0 ]]; then
    local current_content=$(cat "$package_json_path")
    if [[ $current_content == "$original_content" ]]; then
      echo "PASS: Test Case 2 - Function correctly processed package.json without 'main' key."
    else
      echo "FAIL: Test Case 2 - Function modified package.json when it should not have."
      cd "$initial_dir"
      return 1
    fi
  else
    echo "FAIL: Test Case 2 - Function failed unexpectedly."
    cd "$initial_dir"
    return 1
  fi

  # Test Case 3: Package.json exists and has "main" key
  echo "Test Case 3: Package.json exists and has 'main' key"
  echo '{"name": "test", "version": "1.0.0", "main": "index.js"}' >"$package_json_path"
  newTsp_remove_main_from_packagejson "$package_json_path"
  if [[ $? -eq 0 ]]; then
    # Check that the "main" key is no longer present
    if jq 'has("main")' "$package_json_path" | grep -q "true"; then
      echo "FAIL: Test Case 3 - Function should remove 'main' key."
      cd "$initial_dir"
      return 1
    else
      echo "PASS: Test Case 3 - Function correctly removed 'main' key."
    fi
  else
    echo "FAIL: Test Case 3 - Function failed unexpectedly."
    cd "$initial_dir"
    return 1
  fi

  # Test Case 4: Package.json has other content, ensure its preserved.
  echo "Test Case 4: Package.json has other content, ensure its preserved."
  echo '{"name": "test", "version": "1.0.0", "main": "index.js", "scripts": {"test": "echo test"}}' >"$package_json_path"
  newTsp_remove_main_from_packagejson "$package_json_path"
  if [[ $? -eq 0 ]]; then
    if jq 'has("main")' "$package_json_path" | grep -q "true"; then
      echo "FAIL: Test Case 4 - Function should remove 'main' key."
      cd "$initial_dir"
      return 1
    elif [[ "$(jq '.scripts.test' "$package_json_path")" == '"echo test"' ]]; then
      echo "PASS: Test Case 4 - Function correctly removed 'main' key and preserved other content."
    else
      echo "FAIL: Test Case 4 - Function did not preserve other content."
      cd "$initial_dir"
      return 1
    fi
  else
    echo "FAIL: Test Case 4 - Function failed unexpectedly."
    cd "$initial_dir"
    return 1
  fi

  cd "$initial_dir"
  return 0
}
