#!/bin/bash
testNewTspFrontend() {
  echo "🌟 Frontend test party is ON! Let’s get flashy! 😍"
  
  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-frontend-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  local tests_run=0
  local tests_passed=0
  
  echo "🎬 Test Case 1: Crafting a frontend masterpiece with --frontend! 🌐"
  tests_run=$((tests_run + 1))
  
  cd "$test_dir"
  echo "🎨 Executing: newTsp my-frontend-project --frontend"
  newTsp my-frontend-project --frontend
  
  echo "👀 What’s cookin’ in $test_dir?"
  ls -la "$test_dir"
  
  if [ -d "$test_dir/my-frontend-project" ] && 
     [ -f "$test_dir/my-frontend-project/package.json" ] && 
     [ -f "$test_dir/my-frontend-project/tsconfig.frontend.json" ] && 
     [ -f "$test_dir/my-frontend-project/tsconfig.server.json" ] && 
     [ -f "$test_dir/my-frontend-project/jest.config.frontend.js" ] && 
     [ -f "$test_dir/my-frontend-project/jest.e2e.config.js" ] && 
     [ ! -f "$test_dir/my-frontend-project/jest.config.js" ] && 
     [ -d "$test_dir/my-frontend-project/src/frontend" ] && 
     [ -f "$test_dir/my-frontend-project/src/frontend/index.ts" ] && 
     [ -d "$test_dir/my-frontend-project/public" ] && 
     [ -f "$test_dir/my-frontend-project/public/index.html" ]; then
    echo "✅ Huzzah! my-frontend-project is a beauty with --frontend! 🎉"
    
    cd "$test_dir/my-frontend-project"
    if grep -q '"build:frontend"' package.json && 
       grep -q '"serve"' package.json && 
       grep -q '"test:frontend"' package.json && 
       grep -q '"test:e2e"' package.json && 
       grep -q '"test": "concurrently' package.json && 
       npm list puppeteer --depth=0 > /dev/null 2>&1; then
      echo "🎤 Scripts and Puppeteer are droppin’ the mic! ✅"
      tests_passed=$((tests_passed + 1))
    else
      echo "❌ Yikes! Scripts or Puppeteer forgot their lines! 😱"
      jq '.scripts' package.json
    fi
  else
    echo "❌ Oh snap! my-frontend-project is a hot mess! 😵"
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

