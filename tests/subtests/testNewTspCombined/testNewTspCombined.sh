#!/bin/bash
testNewTspCombined() {
  local setup_result=$(testNewTspCombined_setup)
  local initial_dir=$(echo $setup_result | cut -d ':' -f 1)
  local test_dir=$(echo $setup_result | cut -d ':' -f 2)

  # Setup trap that will ALWAYS run on function exit regardless of return path
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT

  local tests_run=0
  local tests_passed=0

  # Run test case 1
  tests_run=$((tests_run + 1))
  if testNewTspCombined_testCase1 "$test_dir"; then
    tests_passed=$((tests_passed + 1))
  fi

  # Run test case 2
  tests_run=$((tests_run + 1))
  if testNewTspCombined_testCase2_mainAbsence "$test_dir"; then
    tests_passed=$((tests_passed + 1))
  fi

  # Show summary and determine overall result
  if testNewTspCombined_summary "$tests_run" "$tests_passed"; then
    return 0
  else
    return 1
  fi
}
