#!/bin/bash
newTsp_parse_args() {
  local args=("$@")
  local project_name=""
  local typezero=false
  local node=false
  local help=false

  for arg in "${args[@]}"; do
    if [[ "$arg" =~ ^-- ]]; then
      # Handle --flags
      if [[ "$arg" == "--typezero" ]]; then
        typezero=true
      elif [[ "$arg" == "--node" ]]; then
        node=true
      elif [[ "$arg" == "--help" ]]; then
        help=true
      fi
    elif [[ "$arg" =~ ^- ]]; then
      # Handle -flags
      if [[ "$arg" == "-n" ]]; then
        node=true
      elif [[ "$arg" == "-h" ]]; then
        help=true
      fi
    else
      # Handle project name (non-flag argument)
      if [ -z "$project_name" ]; then
        project_name="$arg"
      fi
    fi
  done

  # Debugging: Print parsed values
  echo "Debug: project_name=$project_name, typezero=$typezero, node=$node, help=$help" >&2

  # Return parsed values
  echo "$project_name" "$typezero" "$node" "$help"
}

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
  local expected="my-project false false false"
  
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
  expected="my-project true false false"
  
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
  expected="my-project false true false"
  
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
  expected="my-project false true false"
  
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
  expected="my-project true true false"
  
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
  expected="my-project false false true"
  
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
  expected="my-project true true false"
  
  if [[ "$result" == "$expected" ]]; then
    echo "✓ Test case 7 passed"
  else
    echo "✗ Test case 7 failed"
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