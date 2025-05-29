#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspNode_testCase1() {
  local test_dir=$1

  echo "🎯 Test Case 1: Spinning up a Node.js project with --node flag! 🚀"

  cd "$test_dir"
  echo "🔨 Executing: newTsp fuuject --node"
  newTsp fuuject --node

  echo "👀 Peeking at the goodies in $test_dir:"
  ls -la "$test_dir"

  if [ -d "$test_dir/fuuject" ] &&
    [ -f "$test_dir/fuuject/package.json" ] &&
    [ -d "$test_dir/fuuject/src/backend" ] &&
    [ -f "$test_dir/fuuject/src/backend/index.ts" ]; then
    echo "✅ Woohoo! fuuject project is alive and kickin' with --node! 🎉"

    if grep -q '"test:backend"' "$test_dir/fuuject/package.json" &&
      grep -q '"build:backend"' "$test_dir/fuuject/package.json" &&
      grep -q '"test": "npm run test:backend"' "$test_dir/fuuject/package.json"; then
      echo "🎸 Scripts are rockin' the house! ✅"
      return 0
    else
      echo "❌ Uh-oh! Scripts are missing the beat! 😭"
      jq '.scripts' "$test_dir/fuuject/package.json"
      return 1
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
    return 1
  fi
}
