#!/bin/bash
testNewTspFrontend_testCase2_mainAbsence() {
  local test_dir=$1

  echo "🎮 Test Case 2: Ensuring the 'main' key is absent in package.json! 🕵️‍♀️"

  cd "$test_dir/my-frontend-project"

  if jq 'has("main")' package.json | grep -q 'true'; then
    echo "❌ Yikes! package.json has a 'main' key, which is unexpected! 😱"
    jq '.main' package.json
    return 1
  else
    echo "✅ 'main' key is correctly absent. Bravo! 👏"
    return 0
  fi
}

