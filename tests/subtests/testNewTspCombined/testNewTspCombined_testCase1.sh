#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspCombined_testCase1() {
  local test_dir=$1

  echo "🎮 Test Case 1: Building a mega-project with --node AND --frontend! 💪"

  cd "$test_dir"
  echo "🔨 Executing: newTsp my-combined-project --node --frontend"
  newTsp my-combined-project --node --frontend

  echo "👀 What's in the combo box? $test_dir:"
  ls -la "$test_dir"

  if [ -d "$test_dir/my-combined-project" ] &&
    [ -f "$test_dir/my-combined-project/package.json" ] &&
    [ -d "$test_dir/my-combined-project/src/backend" ] &&
    [ -d "$test_dir/my-combined-project/src/frontend" ] &&
    [ -f "$test_dir/my-combined-project/src/backend/index.ts" ] &&
    [ -f "$test_dir/my-combined-project/src/frontend/index.ts" ] &&
    [ -d "$test_dir/my-combined-project/public" ] &&
    [ -f "$test_dir/my-combined-project/public/index.html" ]; then
    echo "✅ Jackpot! my-combined-project is a double-threat WINNER! 🎉"

    cd "$test_dir/my-combined-project"
    if npm list concurrently --depth=0 >/dev/null 2>&1 &&
      npm list puppeteer --depth=0 >/dev/null 2>&1 &&
      grep -q '"test:backend"' package.json &&
      grep -q '"test:frontend"' package.json &&
      grep -q '"build:frontend"' package.json &&
      grep -q '"build:backend"' package.json; then
      echo "🎸 Scripts and concurrently are a triple-hit combo! ✅"

      # Check for the absence of the "main" key
      if jq 'has("main")' package.json | grep -q 'true'; then
        echo "❌ Yikes! package.json has a 'main' key, which is unexpected! 😱"
        jq '.main' package.json
        return 1
      else
        echo "✅ 'main' key is correctly absent. Bravo! 👏"
        return 0
      fi
    else
      echo "❌ Doh! Scripts or dependencies dropped the ball! 😩"
      jq '.scripts' package.json
      return 1
    fi
  else
    echo "❌ Ouch! my-combined-project didn't combo right! 😵"
    ls -la "$test_dir/my-combined-project"

    # Combo-breaker diagnostics! 🕵️‍♀️
    if [ ! -d "$test_dir/my-combined-project" ]; then echo "🏚️ Project dir 'my-combined-project' didn't land!"; fi
    if [ -d "$test_dir/my-combined-project" ]; then
      [ ! -f "$test_dir/my-combined-project/package.json" ] && echo "📜 package.json didn't combo!"
      [ ! -f "$test_dir/my-combined-project/tsconfig.node.json" ] && echo "⚙️ tsconfig.node.json missed the punch!"
      [ ! -f "$test_dir/my-combined-project/tsconfig.frontend.json" ] && echo "⚙️ tsconfig.frontend.json flubbed!"
      [ ! -d "$test_dir/my-combined-project/src/backend" ] && echo "📁 src/backend didn't join!"
      [ -d "$test_dir/my-combined-project/src/backend" ] && [ ! -f "$test_dir/my-combined-project/src/backend/index.ts" ] && echo "📝 backend index.ts is out!"
      [ ! -d "$test_dir/my-combined-project/src/frontend" ] && echo "📁 src/frontend dropped!"
      [ -d "$test_dir/my-combined-project/src/frontend" ] && [ ! -f "$test_dir/my-combined-project/src/frontend/index.ts" ] && echo "📝 frontend index.ts bailed!"
      [ ! -d "$test_dir/my-combined-project/public" ] && echo "📂 public dir didn't show!"
      [ -d "$test_dir/my-combined-project/public" ] && [ ! -f "$test_dir/my-combined-project/public/index.html" ] && echo "🌐 index.html didn't combo!"
    fi
    return 1
  fi
}
