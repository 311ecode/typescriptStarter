#!/bin/bash
testNewTspNode_testCase3() {
  local test_dir=$1

  echo "🎯 Test Case 3: Running the npm test command which should run all tests! 🧪"

  if [ -d "$test_dir/fuuject" ]; then
    cd "$test_dir/fuuject"
    echo "🔍 Running: npm test"
    npm test >test_output.log 2>&1
    test_exit_code=$?

    if [ $test_exit_code -eq 0 ]; then
      echo "✅ npm test passed! Full test suite works! 🎆"
      return 0
    else
      echo "❌ npm test failed! Test suite needs fixing! 🔧"
      echo "Test output:"
      cat test_output.log
      return 1
    fi
  else
    echo "❌ Can't run tests - project directory doesn't exist! 😱"
    return 1
  fi
}
