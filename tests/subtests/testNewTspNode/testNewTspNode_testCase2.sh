#!/bin/bash
testNewTspNode_testCase2() {
  local test_dir=$1

  echo "🧪 Test Case 2: Running the actual tests with npm run test:backend! 🏃‍♂️"

  if [ -d "$test_dir/fuuject" ]; then
    cd "$test_dir/fuuject"
    echo "🔍 Running: npm run test:backend"
    npm run test:backend >test_output.log 2>&1
    test_exit_code=$?

    if [ $test_exit_code -eq 0 ]; then
      echo "✅ Tests passed! The code actually works! 🎯"
      return 0
    else
      echo "❌ Tests failed! Something's broken in paradise! 💔"
      echo "Test output:"
      cat test_output.log
      return 1
    fi
  else
    echo "❌ Can't run tests - project directory doesn't exist! 😱"
    return 1
  fi
}
