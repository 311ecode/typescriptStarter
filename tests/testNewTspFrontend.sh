#!/bin/bash
testNewTspFrontend() {
  echo "🌟 Frontend test party is ON! Let’s get flashy! 😍"
  
  # Where we at? 📍
  local initial_dir=$(pwd)
  
  # Pop-up a temp test stage 🎭
  local test_dir=$(mktemp -d -t newTsp-frontend-test-XXXXXXXXXX)
  
  # Clean-up crew on standby 🧹
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  # Test tally time! 🧮
  local tests_run=0
  local tests_passed=0
  
  # Test Case 2: Frontend Project Creation with --frontend flag 🎨
  echo "🎬 Test Case 2: Crafting a frontend masterpiece with --frontend! 🌐"
  tests_run=$((tests_run + 1))
  
  cd "$test_dir" # Slide into the test zone! 🏄‍♂️
  
  echo "🎨 Executing: newTsp my-frontend-project --frontend"
  newTsp my-frontend-project --frontend
  
  echo "👀 What’s cookin’ in $test_dir?"
  ls -la "$test_dir"
  
  # Did we paint the town red? 🖌️
  if [ -d "$test_dir/my-frontend-project" ] && 
     [ -f "$test_dir/my-frontend-project/package.json" ] && 
     [ -f "$test_dir/my-frontend-project/tsconfig.frontend.json" ] && 
     [ -d "$test_dir/my-frontend-project/src/frontend" ] && 
     [ -f "$test_dir/my-frontend-project/src/frontend/index.ts" ] && 
     [ -d "$test_dir/my-frontend-project/public" ] && 
     [ -f "$test_dir/my-frontend-project/public/index.html" ]; then
    echo "✅ Huzzah! my-frontend-project is a beauty with --frontend! 🎉"
    
    # Are the scripts dazzling? ✨
    if grep -q '"build:frontend"' "$test_dir/my-frontend-project/package.json" && 
       grep -q '"serve"' "$test_dir/my-frontend-project/package.json" && 
       grep -q '"test:frontend"' "$test_dir/my-frontend-project/package.json"; then
      echo "🎤 Scripts are droppin’ the mic! ✅"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Yikes! Scripts forgot their lines! 😱"
      echo "Check the script list:"
      jq '.scripts' "$test_dir/my-frontend-project/package.json"
    fi
  else
    echo "❌ Oh snap! my-frontend-project is a hot mess! 😵"
    echo "Let’s peek inside:"
    ls -la "$test_dir/my-frontend-project"
    
    # Detective mode: what’s missing? 🔍
    if [ ! -d "$test_dir/my-frontend-project" ]; then echo "🏠 Project dir ‘my-frontend-project’ is a ghost town!"; fi
    if [ -d "$test_dir/my-frontend-project" ]; then
      [ ! -f "$test_dir/my-frontend-project/package.json" ] && echo "📜 package.json bailed!"
      [ ! -f "$test_dir/my-frontend-project/tsconfig.frontend.json" ] && echo "⚙️ tsconfig.frontend.json is MIA!"
      [ ! -d "$test_dir/my-frontend-project/src/frontend" ] && echo "📁 src/frontend didn’t show!"
      [ -d "$test_dir/my-frontend-project/src/frontend" ] && [ ! -f "$test_dir/my-frontend-project/src/frontend/index.ts" ] && echo "📝 index.ts flaked!"
      [ ! -d "$test_dir/my-frontend-project/public" ] && echo "📂 public dir is lost!"
      [ -d "$test_dir/my-frontend-project/public" ] && [ ! -f "$test_dir/my-frontend-project/public/index.html" ] && echo "🌐 index.html is a no-show!"
    fi
  fi
  
  # Wrap party! 🎁
  echo ""
  echo "🎲 Tests run: $tests_run"
  echo "🥇 Tests passed: $tests_passed"
  
  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "🌈 Frontend tests are a total win! Party time! 🎉"
    cd "$initial_dir"
    return 0
  else
    echo "😿 Some frontend tests crashed the party! Fix ‘em up! 🔧"
    cd "$initial_dir"
    return 1
  fi
}

