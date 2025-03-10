#!/bin/bash
testNewTspNode() {
  echo "🚀 Launching Node.js backend tests! Buckle up! 😎"
  
  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-node-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  local tests_run=0
  local tests_passed=0
  
  echo "🎯 Test Case 1: Spinning up a Node.js project with --node flag! 🚀"
  tests_run=$((tests_run + 1))
  
  cd "$test_dir"
  echo "🔨 Executing: newTsp fuuject --node"
  newTsp fuuject --node
  
  echo "👀 Peeking at the goodies in $test_dir:"
  ls -la "$test_dir"
  
  if [ -d "$test_dir/fuuject" ] && 
     [ -f "$test_dir/fuuject/package.json" ] && 
     [ -f "$test_dir/fuuject/tsconfig.node.json" ] && 
     [ ! -f "$test_dir/fuuject/jest.config.js" ] && 
     [ -f "$test_dir/fuuject/jest.config.node.js" ] && 
     [ ! -f "$test_dir/fuuject/tsconfig.server.json" ] && 
     [ ! -f "$test_dir/fuuject/jest.e2e.config.js" ] && 
     [ -d "$test_dir/fuuject/src/backend" ] && 
     [ -f "$test_dir/fuuject/src/backend/index.ts" ]; then
    echo "✅ Woohoo! fuuject project is alive and kickin' with --node! 🎉"
    
    if grep -q '"test:backend"' "$test_dir/fuuject/package.json" && 
       grep -q '"build:backend"' "$test_dir/fuuject/package.json" && 
       grep -q '"test": "npm run test:backend"' "$test_dir/fuuject/package.json"; then
      echo "🎸 Scripts are rockin' the house! ✅"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Uh-oh! Scripts are missing the beat! 😭"
      jq '.scripts' "$test_dir/fuuject/package.json"
    fi
  else
    echo "❌ Oof! fuuject project is a no-show or half-baked! 😢"
    ls -la "$test_dir/fuuject"
    
    # Sherlock mode: what went wrong? 🕵️‍♂️
    if [ ! -d "$test_dir/fuuject" ]; then echo "🏚️ Project dir 'fuuject' didn't show up!"; fi
    if [ -d "$test_dir/fuuject" ]; then
      [ ! -f "$test_dir/fuuject/package.json" ] && echo "📜 package.json is AWOL!"
      [ ! -f "$test_dir/fuuject/tsconfig.node.json" ] && echo "⚙️ tsconfig.node.json ghosted us!"
      [ ! -d "$test_dir/fuuject/src/backend" ] && echo "📁 src/backend didn't RSVP!"
      [ -d "$test_dir/fuuject/src/backend" ] && [ ! -f "$test_dir/fuuject/src/backend/index.ts" ] && echo "📝 index.ts ditched the party!"
    fi
  fi
  
  # NEW TEST CASE: Check if npm run test:backend actually works
  echo "🧪 Test Case 2: Running the actual tests with npm run test:backend! 🏃‍♂️"
  tests_run=$((tests_run + 1))
  
  if [ -d "$test_dir/fuuject" ]; then
    cd "$test_dir/fuuject"
    echo "🔍 Running: npm run test:backend"
    npm run test:backend > test_output.log 2>&1
    test_exit_code=$?
    
    if [ $test_exit_code -eq 0 ]; then
      echo "✅ Tests passed! The code actually works! 🎯"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Tests failed! Something's broken in paradise! 💔"
      echo "Test output:"
      cat test_output.log
    fi
  else
    echo "❌ Can't run tests - project directory doesn't exist! 😱"
  fi
  
  # Wrap it up! 📦
  echo ""
  echo "🎮 Tests run: $tests_run"
  echo "🏆 Tests passed: $tests_passed"
  
  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "🎉 All Node tests crushed it! High five! ✋"
    cd "$initial_dir"
    return 0
  else
    echo "😵 Some Node tests flopped! Time to debug! 🔧"
    cd "$initial_dir"
    return 1
  fi
}