#!/bin/bash
#
# Updated test function for newTsp command
#

testNewTsp() {
  # Store initial directory
  local initial_dir=$(pwd)
  
  # Create temporary test directory
  local test_dir=$(mktemp -d -t newTsp-test-XXXXXXXXXX)
  
  # Set up trap to ensure cleanup and return to initial directory
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  # Initialize test counters
  local tests_run=0
  local tests_passed=0
  
  echo "Running newTsp tests..."
  
  # Change to test directory
  cd "$test_dir"
  
  # Test Case 1: Standard Node Project Creation with --node flag
  echo "Test Case 1: Create a standard Node.js project with --node flag"
  tests_run=$((tests_run + 1))
  
  # Execute the command being tested
  echo "Executing: newTsp fuuject --node"
  newTsp fuuject --node
  
  # For debugging, let's see what folders were created
  echo "Listing the test directory content:"
  ls -la "$test_dir"
  
  # Verify the project was created correctly
  if [ -d "$test_dir/fuuject" ] && 
     [ -f "$test_dir/fuuject/package.json" ] && 
     [ -f "$test_dir/fuuject/tsconfig.node.json" ] && 
     [ -f "$test_dir/fuuject/tsconfig.json" ] && 
     [ -f "$test_dir/fuuject/jest.config.node.js" ] && 
     [ -f "$test_dir/fuuject/jest.config.js" ] && 
     [ -d "$test_dir/fuuject/src" ] && 
     [ -f "$test_dir/fuuject/src/index.ts" ]; then
    echo "✅ PASSED: fuuject project created successfully with --node flag"
    
    # Check for correct package.json scripts
    if grep -q '"test": "npm run test:node"' "$test_dir/fuuject/package.json" && 
       grep -q '"test:node": "npx jest --config jest.config.node.js --coverage"' "$test_dir/fuuject/package.json" && 
       grep -q '"typecheck": "tsc --project tsconfig.node.json"' "$test_dir/fuuject/package.json"; then
      echo "✅ PASSED: package.json scripts are correctly configured"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ FAILED: package.json does not contain expected script configuration"
      echo "Content of package.json scripts:"
      jq '.scripts' "$test_dir/fuuject/package.json"
    fi
  else
    echo "❌ FAILED: fuuject project structure is incomplete or incorrect"
    echo "Directory listing:"
    ls -la "$test_dir/fuuject"
    
    if [ ! -d "$test_dir/fuuject" ]; then
      echo "Project directory 'fuuject' was not created"
    fi
    
    if [ -d "$test_dir/fuuject" ]; then
      if [ ! -f "$test_dir/fuuject/package.json" ]; then
        echo "package.json was not created"
      fi
      
      if [ ! -f "$test_dir/fuuject/tsconfig.node.json" ]; then
        echo "tsconfig.node.json was not created"
      fi
      
      if [ ! -f "$test_dir/fuuject/tsconfig.json" ]; then
        echo "tsconfig.json was not created"
      fi
      
      if [ ! -f "$test_dir/fuuject/jest.config.node.js" ]; then
        echo "jest.config.node.js was not created"
      fi
      
      if [ ! -f "$test_dir/fuuject/jest.config.js" ]; then
        echo "jest.config.js was not created"
      fi
      
      if [ ! -d "$test_dir/fuuject/src" ]; then
        echo "src directory was not created"
      elif [ ! -f "$test_dir/fuuject/src/index.ts" ]; then
        echo "src/index.ts was not created"
      fi
    fi
  fi
  
  # Clean up project directory for next test
  rm -rf "$test_dir/fuuject"
  
  # Report test results
  echo ""
  echo "Tests completed: $tests_run"
  echo "Tests passed: $tests_passed"
  
  # Determine overall test success/failure
  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "All tests passed! 🎉"
    cd "$initial_dir"
    return 0
  else
    echo "Some tests failed! ❌"
    cd "$initial_dir"
    return 1
  fi
}