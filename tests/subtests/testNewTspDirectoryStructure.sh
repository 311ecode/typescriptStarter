#!/bin/bash
testNewTspDirectoryStructure() {
  echo "🏗️ Directory structure test marathon! Everything in its right place! 📂"
  
  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-dir-test-XXXXXXXXXX)
  trap 'rm -rf "$test_dir"; cd "$initial_dir"' EXIT
  
  local tests_run=0
  local tests_passed=0

  # Test Node.js structure
  tests_run=$((tests_run + 1))
  cd "$test_dir"
  newTsp node-project --node
  if [ -d "node-project/src/backend" ] &&
     [ -f "node-project/tsconfig.node.json" ]; then
    echo "✅ Node structure perfect! 🐢"
    tests_passed=$((tests_passed + 1))
  else
    echo "❌ Node structure missing pieces!"
  fi

  # Test Frontend structure
  tests_run=$((tests_run + 1))
  cd "$test_dir"
  newTsp frontend-project --frontend
  if [ -d "frontend-project/public" ] &&
     [ -f "frontend-project/tsconfig.frontend.json" ]; then
    echo "✅ Frontend structure flawless! 🎨"
    tests_passed=$((tests_passed + 1))
  else
    echo "❌ Frontend structure incomplete!"
  fi

  # Results
  echo "📊 Directory tests: $tests_passed/$tests_run passed!"
  return $((tests_run - tests_passed))
}

