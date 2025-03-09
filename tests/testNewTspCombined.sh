#!/bin/bash
testNewTspCombined() {
  echo "🎉 Combo test extravaganza! Node + Frontend = Epic! 🚀"
  
  # Mark our spot 📍
  local initial_dir=$(pwd)
  
  # Temp test arena incoming! 🏟️
  local test_dir=$(mktemp -d -t newTsp-combo-test-XXXXXXXXXX)
  
  # Cleanup crew ready! 🧼
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  # Test scorekeepers on duty! 📊
  local tests_run=0
  local tests_passed=0
  
  # Test Case 3: Combined Project Creation with both flags! 🎯
  echo "🎮 Test Case 3: Building a mega-project with --node AND --frontend! 💪"
  tests_run=$((tests_run + 1))
  
  cd "$test_dir" # Jump into the action! 🏃‍♀️
  
  echo "🔨 Executing: newTsp my-combined-project --node --frontend"
  newTsp my-combined-project --node --frontend
  
  echo "👀 What’s in the combo box? $test_dir:"
  ls -la "$test_dir"
  
  # Did we hit the jackpot? 🎰
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
    echo "✅ Jackpot! my-combined-project is a double-threat WINNER! 🎉"
    
    # Scripts check—double the fun! 🎷
    if grep -q '"build:frontend"' "$test_dir/my-combined-project/package.json" && 
       grep -q '"build:backend"' "$test_dir/my-combined-project/package.json" && 
       grep -q '"test:frontend"' "$test_dir/my-combined-project/package.json" && 
       grep -q '"test:backend"' "$test_dir/my-combined-project/package.json"; then
      echo "🎸 Scripts are a double-hit combo! ✅"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Doh! Scripts dropped the ball on this combo! 😩"
      echo "Here’s the script rundown:"
      jq '.scripts' "$test_dir/my-combined-project/package.json"
    fi
  else
    echo "❌ Ouch! my-combined-project didn’t combo right! 😵"
    echo "Let’s see the damage:"
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

