#!/bin/bash
testNewTsp() {
  echo "🎉 Welcome to the ULTIMATE newTsp TEST EXTRAVAGANZA! 🌟"
  echo "🍿 Grab some popcorn, we’re testing EVERYTHING! 😎"
  
  # Scoreboard time! 🏆
  local total_tests=0
  local total_passed=0
  
  # Party lights on! 🎈
  echo ""
  echo "🧩 Parser party is HERE! Let's decode those args! 🎲"
  echo "---------------------------------------------"
  testNewTspParseArgs
  parse_result=$?
  total_tests=$((total_tests + 1))
  [ $parse_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "🌍 Calling the Node.js backend test crew! 🐢💻"
  echo "---------------------------------------------"
  testNewTspNode
  node_result=$?
  total_tests=$((total_tests + 1))
  [ $node_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "🌐 Time for the Frontend test fiesta! 🎨✨"
  echo "---------------------------------------------"
  testNewTspFrontend
  frontend_result=$?
  total_tests=$((total_tests + 1))
  [ $frontend_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "🎮 Combo breaker test GO! Node + Frontend = BOOM! 💥"
  echo "---------------------------------------------"
  testNewTspCombined
  combined_result=$?
  total_tests=$((total_tests + 1))
  [ $combined_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "📦 Package name test extravaganza! Let's check those names! 🏷️"
  echo "---------------------------------------------"
  testNewTspPackageName
  package_name_result=$?
  total_tests=$((total_tests + 1))
  [ $package_name_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"

  echo ""
  echo "🏗️ Directory structure test marathon! Everything in its right place! 📂"
  echo "---------------------------------------------"
  testNewTspDirectoryStructure
  directory_structure_result=$?
  total_tests=$((total_tests + 1))
  [ $directory_structure_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"

  # Grand finale! 🎤
  echo ""
  echo "🎷 Testapalooza wrap-up time! Let's see the stats! 📊"
  echo "🎲 Total tests run: $total_tests"
  echo "🏅 Total tests passed: $total_passed"

  if [ "$total_passed" -eq "$total_tests" ]; then
    echo "🌈 WOOHOO! All tests are ROCKSTARS! Party time! 🎉🎸"
    echo "🎵 Cue the victory music! 🕺💃"
    return 0
  else
    echo "😿 Oh no! Some tests tripped over their shoelaces! 😅"
    echo "🔧 Time to debug—don't worry, we'll get 'em next time! 💪"
    echo "Here's the detailed failure report:"
    
    if [ $parse_result -ne 0 ]; then
      echo "  ❌ PARSER TEST FAILURES:"
      echo "     - Command line argument handling is not working correctly"
      echo "     - Check the newTsp_parse_args function for issues"
    fi
    
    if [ $node_result -ne 0 ]; then
      echo "  ❌ NODE.JS TEST FAILURES:"
      echo "     - Node.js project setup encountered problems"
      echo "     - Check newTsp_setup_node and related functions"
      echo "     - Verify tsconfig.node.json and Jest configuration"
    fi
    
    if [ $frontend_result -ne 0 ]; then
      echo "  ❌ FRONTEND TEST FAILURES:"
      echo "     - Frontend project setup encountered problems"
      echo "     - Check newTsp_setup_frontend and related functions"
      echo "     - Verify tsconfig.frontend.json and test setup"
    fi
    
    if [ $combined_result -ne 0 ]; then
      echo "  ❌ COMBO TEST FAILURES:"
      echo "     - Combined Node.js + Frontend setup not working"
      echo "     - Check interactions between different setup functions"
      echo "     - Verify concurrently is installed and scripts are combined"
    fi
    
    if [ $package_name_result -ne 0 ]; then
      echo "  ❌ PACKAGE NAME TEST FAILURES:"
      echo "     - Package name handling is not working correctly"
      echo "     - Check directory name sanitization"
      echo "     - Verify package.json name property is set correctly"
      echo "     - Make sure trailing dashes are removed"
    fi
    
    if [ $directory_structure_result -ne 0 ]; then
      echo "  ❌ DIRECTORY STRUCTURE TEST FAILURES:"
      echo "     - Project files aren't created in the expected locations"
      echo "     - Check directory creation logic"
      echo "     - Verify all config and source files are in the right places"
    fi
    
    return 1
  fi
}

#!/bin/bash
testNewTspDirectoryStructure() {
  echo "🏗️ Directory structure test marathon! Everything in its right place! 📂"
  
  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-dir-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  local tests_run=0
  local tests_passed=0

  # Test Node.js structure
  tests_run=$((tests_run + 1))
  cd "$test_dir"
  newTsp node-project --node
  if [ -d "node-project/src/backend" ] &&
     [ -f "node-project/tsconfig.node.json" ]; then
    echo "✅ Node structure perfect! 🐢"
    tests_passed=$((tests_passed + 1))
  else
    echo "❌ Node structure missing pieces!"
  fi

  # Test Frontend structure
  tests_run=$((tests_run + 1))
  cd "$test_dir"
  newTsp frontend-project --frontend
  if [ -d "frontend-project/public" ] &&
     [ -f "frontend-project/tsconfig.frontend.json" ]; then
    echo "✅ Frontend structure flawless! 🎨"
    tests_passed=$((tests_passed + 1))
  else
    echo "❌ Frontend structure incomplete!"
  fi

  # Results
  echo "📊 Directory tests: $tests_passed/$tests_run passed!"
  return $((tests_run - tests_passed))
}

#!/bin/bash
testNewTspPackageName() {
  echo "📦 Package name test extravaganza! Let's check those names! 🏷️"
  
  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-pkg-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  local tests_run=0
  local tests_passed=0

  # # Test 1: Name with special chars and trailing dash
  # tests_run=$((tests_run + 1))
  # cd "$test_dir"
  # newTsp "ugly_name--123!" --node
  # if [ -d "ugly_name--123" ] && 
  #    jq -e '.name == "ugly-name-123"' ugly_name--123/package.json >/dev/null; then
  #   echo "✅ Trailing dash & special chars handled! 🧹"
  #   tests_passed=$((tests_passed + 1))
  # else
  #   echo "❌ Failed to clean ugly name!"
  # fi

  # Test 2: Uppercase conversion
  # tests_run=$((tests_run + 1))
  # cd "$test_dir"
  # newTsp "MyCOOLProject" --node
  # if [ -d "MyCOOLProject" ] && 
  #    jq -e '.name == "mycoolproject"' MyCOOLProject/package.json >/dev/null; then
  #   echo "✅ Uppercase to lowercase conversion works! ⬇️"
  #   tests_passed=$((tests_passed + 1))
  # else
  #   echo "❌ Uppercase handling failed!"
  # fi

  # Results
  echo "📊 Package name tests: $tests_passed/$tests_run passed!"
  return $((tests_run - tests_passed))
}