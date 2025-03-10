#!/bin/bash
testNewTsp() {
  # Initialize test environment and get initial directory
  local initial_dir=$(testNewTsp_initialize)
  
  # Scoreboard time! 🏆
  local total_tests=0
  local total_passed=0
  
  # Define array of test functions
  local test_functions=(
    "testNewTsp_runParserTest"
    "testNewTsp_runNodeTest"
    "testNewTsp_runFrontendTest"
    "testNewTsp_runCombinedTest"
    "testNewTsp_runPackageNameTest"
    "testNewTsp_runDirectoryStructureTest"
  )
  
  # Array to store results
  local results=()
  
  # Run all tests
  for test_func in "${test_functions[@]}"; do
    $test_func
    local result=$?
    results+=($result)
    total_tests=$((total_tests + 1))
    [ $result -eq 0 ] && total_passed=$((total_passed + 1))
  done
  
  # Summarize and report results
  testNewTsp_summarizeResults $total_tests $total_passed "$initial_dir" "${results[@]}"
  
  return $?
}