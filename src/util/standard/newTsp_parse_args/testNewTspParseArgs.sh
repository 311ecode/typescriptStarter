#!/bin/bash
testNewTspParseArgs() {
  local initial_dir=$(pwd)
  trap 'cd "$initial_dir"' EXIT
  
  # Create a temporary test directory
  local test_dir=$(mktemp -d -t test-XXXXXXXXXX)
  cd "$test_dir"
  
  echo "Testing newTsp_parse_args function..."
  
  local all_tests_passed=true
  
  # Test case 1: Project name only
  echo "Test case 1: Project name only (lone string)"
  local result=$(newTsp_parse_args "my-project")
  local expected="my-project false false false false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 1 passed"
  else
    echo "✗ Test case 1 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 2: Project name with --typezero flag
  echo "Test case 2: Project name with --typezero flag"
  result=$(newTsp_parse_args "my-project" "--typezero")
  expected="my-project true false false false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 2 passed"
  else
    echo "✗ Test case 2 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 3: Project name with --node flag
  echo "Test case 3: Project name with --node flag"
  result=$(newTsp_parse_args "my-project" "--node")
  expected="my-project false true false false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 3 passed"
  else
    echo "✗ Test case 3 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 4: Project name with -n flag (shorthand for --node)
  echo "Test case 4: Project name with -n flag"
  result=$(newTsp_parse_args "my-project" "-n")
  expected="my-project false true false false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 4 passed"
  else
    echo "✗ Test case 4 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 5: Project name with multiple flags
  echo "Test case 5: Project name with multiple flags"
  result=$(newTsp_parse_args "my-project" "--typezero" "--node")
  expected="my-project true true false false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 5 passed"
  else
    echo "✗ Test case 5 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 6: Project name with help flag
  echo "Test case 6: Project name with help flag"
  result=$(newTsp_parse_args "my-project" "--help")
  expected="my-project false false false true"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 6 passed"
  else
    echo "✗ Test case 6 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 7: Multiple flags in different orders
  echo "Test case 7: Multiple flags in different orders"
  result=$(newTsp_parse_args "--node" "my-project" "--typezero")
  expected="my-project true true false false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 7 passed"
  else
    echo "✗ Test case 7 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 8: Project name with --frontend flag
  echo "Test case 8: Project name with --frontend flag"
  result=$(newTsp_parse_args "my-project" "--frontend")
  expected="my-project false false true false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 8 passed"
  else
    echo "✗ Test case 8 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 9: Project name with --frontend and --typezero flags
  echo "Test case 9: Project name with --frontend and --typezero flags"
  result=$(newTsp_parse_args "my-project" "--frontend" "--typezero")
  expected="my-project true false true false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 9 passed"
  else
    echo "✗ Test case 9 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Test case 10: All flags including --frontend
  echo "Test case 10: All flags including --frontend"
  result=$(newTsp_parse_args "my-project" "--typezero" "--node" "--frontend" "--help")
  expected="my-project true true true true"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 10 passed"
  else
    echo "✗ Test case 10 failed"
    echo "  Expected: $expected"
    echo "  Got:      $result"
    all_tests_passed=false
  fi
  
  # Return to initial directory and return test result
  cd "$initial_dir"
  rm -rf "$test_dir"
  
  if $all_tests_passed; then
    echo "All newTsp_parse_args tests passed!"
    return 0
  else
    echo "Some newTsp_parse_args tests failed!"
    return 1
  fi
}
