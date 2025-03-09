#!/bin/bash
testNewTspCombined() {
  echo "🎉 Combo test extravaganza! Node + Frontend = Epic! 🚀"

  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-combo-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT

  local tests_run=0
  local tests_passed=0

  echo "🎮 Test Case 1: Building a mega-project with --node AND --frontend! 💪"
  tests_run=$((tests_run + 1))

 cd "$test_dir"
  echo "🔨 Executing: newTsp my-combined-project --node --frontend"
  newTsp my-combined-project --node --frontend

  echo "👀 What’s in the combo box? $test_dir:"
  ls -la "$test_dir"

  if [ -d "$test_dir/my-combined-project" ] && 
     [ -f "$test_dir/my-combined-project/package.json" ] && 
     [ -f "$test_dir/my-combined-project/tsconfig.node.json" ] && 
     [ -f "$test_dir/my-combined-project/tsconfig.frontend.json" ] && 
     [ -f "$test_dir/my-combined-project/tsconfig.server.json" ] && 
     [ -f "$test_dir/my-combined-project/jest.config.node.js" ] && 
     [ -f "$test_dir/my-combined-project/jest.config.frontend.js" ] && 
     [ -f "$test_dir/my-combined-project/jest.e2e.config.js" ] && 
     [ ! -f "$test_dir/my-combined-project/jest.config.js" ] && 
     [ -d "$test_dir/my-combined-project/src/backend" ] && 
     [ -d "$test_dir/my-combined-project/src/frontend" ] && 
     [ -f "$test_dir/my-combined-project/src/backend/index.ts" ] && 
     [ -f "$test_dir/my-combined-project/src/frontend/index.ts" ] && 
     [ -d "$test_dir/my-combined-project/public" ] && 
     [ -f "$test_dir/my-combined-project/public/index.html" ]; then
    echo "✅ Jackpot! my-combined-project is a double-threat WINNER! 🎉"

    cd "$test_dir/my-combined-project"
    if npm list concurrently --depth=0 > /dev/null 2>&1 && 
       npm list puppeteer --depth=0 > /dev/null 2>&1 && 
       grep -q '"test": "concurrently' package.json && 
       grep -q '"test:backend"' package.json && 
       grep -q '"test:frontend"' package.json && 
       grep -q '"test:e2e"' package.json && 
       grep -q '"build:frontend"' package.json && 
       grep -q '"build:backend"' package.json; then
      echo "🎸 Scripts and concurrently are a triple-hit combo! ✅"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Doh! Scripts or dependencies dropped the ball! 😩"
      jq '.scripts' package.json
    fi
  else
    echo "❌ Ouch! my-combined-project didn’t combo right! 😵"
    ls -la "$test_dir/my-combined-project"

    # Combo-breaker diagnostics! 🕵️‍♀️
    if [ ! -d "$test_dir/my-combined-project" ]; then echo "🏚️ Project dir ‘my-combined-project’ didn’t land!"; fi
    if [ -d "$test_dir/my-combined-project" ]; then
      [ ! -f "$test_dir/my-combined-project/package.json" ] && echo "📜 package.json didn’t combo!"
      [ ! -f "$test_dir/my-combined-project/tsconfig.node.json" ] && echo "⚙️ tsconfig.node.json missed the punch!"
      [ ! -f "$test_dir/my-combined-project/tsconfig.frontend.json" ] && echo "⚙️ tsconfig.frontend.json flubbed!"
      [ ! -d "$test_dir/my-combined-project/src/backend" ] && echo "📁 src/backend didn’t join!"
      [ -d "$test_dir/my-combined-project/src/backend" ] && [ ! -f "$test_dir/my-combined-project/src/backend/index.ts" ] && echo "📝 backend index.ts is out!"
      [ ! -d "$test_dir/my-combined-project/src/frontend" ] && echo "📁 src/frontend dropped!"
      [ -d "$test_dir/my-combined-project/src/frontend" ] && [ ! -f "$test_dir/my-combined-project/src/frontend/index.ts" ] && echo "📝 frontend index.ts bailed!"
      [ ! -d "$test_dir/my-combined-project/public" ] && echo "📂 public dir didn’t show!"
      [ -d "$test_dir/my-combined-project/public" ] && [ ! -f "$test_dir/my-combined-project/public/index.html" ] && echo "🌐 index.html didn’t combo!"
    fi
  fi

  # Final score! 🏅
  echo ""
  echo "🎲 Tests run: $tests_run"
  echo "🥇 Tests passed: $tests_passed"

  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "🎉 Combo tests are a SMASH HIT! Victory dance! 💃🕺"
    cd "$initial_dir"
    return 0
  else
    echo "😿 Combo tests took a hit! Back to the dojo! 🥋"
    cd "$initial_dir"
    return 1
  fi
}