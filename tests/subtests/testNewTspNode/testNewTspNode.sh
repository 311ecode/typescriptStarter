#!/bin/bash

# Main function that calls all subfunctions
testNewTspNode() {
  local setup_result=$(testNewTspNode_setup)
  local initial_dir=$(echo $setup_result | cut -d ':' -f 1)
  local test_dir=$(echo $setup_result | cut -d ':' -f 2)
  local test_result=0

  # Setup trap that will ALWAYS run on function exit regardless of return path
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT

  local tests_run=0
  local tests_passed=0

  # Run test case 1
  tests_run=$((tests_run + 1))
  if testNewTspNode_testCase1 "$test_dir"; then
    tests_passed=$((tests_passed + 1))
  fi

  # Run test case 2
  tests_run=$((tests_run + 1))
  if testNewTspNode_testCase2 "$test_dir"; then
    tests_passed=$((tests_passed + 1))
  fi

  # Run test case 3
  tests_run=$((tests_run + 1))
  if testNewTspNode_testCase3 "$test_dir"; then
    tests_passed=$((tests_passed + 1))
  fi

  # Show summary and determine overall result
  if ! testNewTspNode_summary "$tests_run" "$tests_passed"; then
    test_result=1
  fi

  # Don't need explicit cd here - trap will handle it
  return $test_result
}
