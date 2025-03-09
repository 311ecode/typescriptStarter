#!/bin/bash
testNewTspNode() {
  echo "🚀 Launching Node.js backend tests! Buckle up! 😎"
  
  # Grab the starting spot 🌏
  local initial_dir=$(pwd)
  
  # Whip up a temp test playground 🎪
  local test_dir=$(mktemp -d -t newTsp-node-test-XXXXXXXXXX)
  
  # Safety net: clean up and bounce back home 🏡
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  # Test counters ready to roll 🎲
  local tests_run=0
  local tests_passed=0
  
  # Test Case 1: Standard Node Project Creation with --node flag 🐢
  echo "🎯 Test Case 1: Spinning up a Node.js project with --node flag! 🚀"
  tests_run=$((tests_run + 1))
  
  cd "$test_dir" # Hop into the test zone! 🏃‍♂️
  
  echo "🔨 Executing: newTsp fuuject --node"
  newTsp fuuject --node
  
  echo "👀 Peeking at the goodies in $test_dir:"
  ls -la "$test_dir"
  
  # Did we nail it? 🛠️
  if [ -d "$test_dir/fuuject" ] && 
     [ -f "$test_dir/fuuject/package.json" ] && 
     [ -f "$test_dir/fuuject/tsconfig.node.json" ] && 
     [ -d "$test_dir/fuuject/src/backend" ] && 
     [ -f "$test_dir/fuuject/src/backend/index.ts" ]; then
    echo "✅ Woohoo! fuuject project is alive and kickin’ with --node! 🎉"
    
    # Check those sweet package.json scripts 🎵
    if grep -q '"test:backend"' "$test_dir/fuuject/package.json" && 
       grep -q '"build:backend"' "$test_dir/fuuject/package.json"; then
      echo "🎸 Scripts are rockin’ the house! ✅"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Uh-oh! Scripts are missing the beat! 😭"
      echo "Here’s the package.json deets:"
      jq '.scripts' "$test_dir/fuuject/package.json"
    fi
  else
    echo "❌ Oof! fuuject project is a no-show or half-baked! 😢"
    echo "What’s in there? Let’s see:"
    ls -la "$test_dir/fuuject"
    
    # Sherlock mode: what went wrong? 🕵️‍♂️
    if [ ! -d "$test_dir/fuuject" ]; then echo "🏚️ Project dir ‘fuuject’ didn’t show up!"; fi
    if [ -d "$test_dir/fuuject" ]; then
      [ ! -f "$test_dir/fuuject/package.json" ] && echo "📜 package.json is AWOL!"
      [ ! -f "$test_dir/fuuject/tsconfig.node.json" ] && echo "⚙️ tsconfig.node.json ghosted us!"
      [ ! -d "$test_dir/fuuject/src/backend" ] && echo "📁 src/backend didn’t RSVP!"
      [ -d "$test_dir/fuuject/src/backend" ] && [ ! -f "$test_dir/fuuject/src/backend/index.ts" ] && echo "📝 index.ts ditched the party!"
    fi
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

