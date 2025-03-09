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
     [ -d "$test_dir/fuuject/src/backend" ] && 
     [ -f "$test_dir/fuuject/src/backend/index.ts" ]; then
    echo "✅ PASSED: fuuject project created successfully with --node flag"
    
    # Check for correct package.json scripts
    if grep -q '"test:backend"' "$test_dir/fuuject/package.json" && 
       grep -q '"build:backend"' "$test_dir/fuuject/package.json"; then
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
    
    # Detailed diagnostics
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
      
      if [ ! -d "$test_dir/fuuject/src/backend" ]; then
        echo "src/backend directory was not created"
      elif [ ! -f "$test_dir/fuuject/src/backend/index.ts" ]; then
        echo "src/backend/index.ts was not created"
      fi
    fi
  fi
  
  # Clean up project directory for next test
  rm -rf "$test_dir/fuuject"
  
  # Test Case 2: Frontend Project Creation with --frontend flag
  echo "Test Case 2: Create a frontend project with --frontend flag"
  tests_run=$((tests_run + 1))
  
  # Execute the command being tested
  echo "Executing: newTsp my-frontend-project --frontend"
  newTsp my-frontend-project --frontend
  
  # Verify the project was created correctly
  if [ -d "$test_dir/my-frontend-project" ] && 
     [ -f "$test_dir/my-frontend-project/package.json" ] && 
     [ -f "$test_dir/my-frontend-project/tsconfig.frontend.json" ] && 
     [ -d "$test_dir/my-frontend-project/src/frontend" ] && 
     [ -f "$test_dir/my-frontend-project/src/frontend/index.ts" ] && 
     [ -d "$test_dir/my-frontend-project/public" ] && 
     [ -f "$test_dir/my-frontend-project/public/index.html" ]; then
    echo "✅ PASSED: my-frontend-project created successfully with --frontend flag"
    
    # Check for correct package.json scripts
    if grep -q '"build:frontend"' "$test_dir/my-frontend-project/package.json" && 
       grep -q '"serve"' "$test_dir/my-frontend-project/package.json" && 
       grep -q '"test:frontend"' "$test_dir/my-frontend-project/package.json"; then
      echo "✅ PASSED: package.json scripts are correctly configured for frontend"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ FAILED: package.json does not contain expected script configuration for frontend"
      echo "Content of package.json scripts:"
      jq '.scripts' "$test_dir/my-frontend-project/package.json"
    fi
  else
    echo "❌ FAILED: my-frontend-project structure is incomplete or incorrect"
    echo "Directory listing:"
    ls -la "$test_dir/my-frontend-project"
    
    # Detailed failure diagnostics
    if [ ! -d "$test_dir/my-frontend-project" ]; then
      echo "Project directory 'my-frontend-project' was not created"
    fi
    
    if [ -d "$test_dir/my-frontend-project" ]; then
      if [ ! -f "$test_dir/my-frontend-project/package.json" ]; then
        echo "package.json was not created"
      fi
      
      if [ ! -f "$test_dir/my-frontend-project/tsconfig.frontend.json" ]; then
        echo "tsconfig.frontend.json was not created"
      fi
      
      if [ ! -d "$test_dir/my-frontend-project/src/frontend" ]; then
        echo "src/frontend directory was not created"
      elif [ ! -f "$test_dir/my-frontend-project/src/frontend/index.ts" ]; then
        echo "src/frontend/index.ts was not created"
      fi
      
      if [ ! -d "$test_dir/my-frontend-project/public" ]; then
        echo "public directory was not created"
      elif [ ! -f "$test_dir/my-frontend-project/public/index.html" ]; then
        echo "public/index.html was not created"
      fi
    fi
  fi
  
  # Clean up project directory for next test
  rm -rf "$test_dir/my-frontend-project"
  
  # Test Case 3: Combined Project Creation with both --node and --frontend flags
  echo "Test Case 3: Create a combined project with both --node and --frontend flags"
  tests_run=$((tests_run + 1))
  
  # Execute the command being tested
  echo "Executing: newTsp my-combined-project --node --frontend"
  newTsp my-combined-project --node --frontend
  
  # Verify the project was created correctly
  if [ -d "$test_dir/my-combined-project" ] && 
     [ -f "$test_dir/my-combined-project/package.json" ] && 
     [ -f "$test_dir/my-combined-project/tsconfig.node.json" ] && 
     [ -f "$test_dir/my-combined-project/tsconfig.frontend.json" ] && 
     [ -d "$test_dir/my-combined-project/src/backend" ] && 
     [ -d "$test_dir/my-combined-project/src/frontend" ] && 
     [ -f "$test_dir/my-combined-project/src/backend/index.ts" ] && 
     [ -f "$test_dir/my-combined-project/src/frontend/index.ts" ] && 
     [ -d "$test_dir/my-combined-project/public" ] && 
     [ -f "$test_dir/my-combined-project/public/index.html" ]; then
    echo "✅ PASSED: my-combined-project created successfully with both --node and --frontend flags"
    
    # Check for correct package.json scripts for both frontend and backend
    if grep -q '"build:frontend"' "$test_dir/my-combined-project/package.json" && 
       grep -q '"build:backend"' "$test_dir/my-combined-project/package.json" && 
       grep -q '"test:frontend"' "$test_dir/my-combined-project/package.json" && 
       grep -q '"test:backend"' "$test_dir/my-combined-project/package.json"; then
      echo "✅ PASSED: package.json scripts are correctly configured for combined project"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ FAILED: package.json does not contain expected script configuration for combined project"
      echo "Content of package.json scripts:"
      jq '.scripts' "$test_dir/my-combined-project/package.json"
    fi
  else
    echo "❌ FAILED: my-combined-project structure is incomplete or incorrect"
    echo "Directory listing:"
    ls -la "$test_dir/my-combined-project"
    
    # Detailed failure diagnostics
    if [ ! -d "$test_dir/my-combined-project" ]; then
      echo "Project directory 'my-combined-project' was not created"
    fi
    
    if [ -d "$test_dir/my-combined-project" ]; then
      if [ ! -f "$test_dir/my-combined-project/package.json" ]; then
        echo "package.json was not created"
      fi
      
      if [ ! -f "$test_dir/my-combined-project/tsconfig.node.json" ]; then
        echo "tsconfig.node.json was not created"
      fi
      
      if [ ! -f "$test_dir/my-combined-project/tsconfig.frontend.json" ]; then
        echo "tsconfig.frontend.json was not created"
      fi
      
      if [ ! -d "$test_dir/my-combined-project/src/backend" ]; then
        echo "src/backend directory was not created"
      elif [ ! -f "$test_dir/my-combined-project/src/backend/index.ts" ]; then
        echo "src/backend/index.ts was not created"
      fi
      
      if [ ! -d "$test_dir/my-combined-project/src/frontend" ]; then
        echo "src/frontend directory was not created"
      elif [ ! -f "$test_dir/my-combined-project/src/frontend/index.ts" ]; then
        echo "src/frontend/index.ts was not created"
      fi
      
      if [ ! -d "$test_dir/my-combined-project/public" ]; then
        echo "public directory was not created"
      elif [ ! -f "$test_dir/my-combined-project/public/index.html" ]; then
        echo "public/index.html was not created"
      fi
    fi
  fi
  
  # Clean up project directory for next test
  rm -rf "$test_dir/my-combined-project"
  
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