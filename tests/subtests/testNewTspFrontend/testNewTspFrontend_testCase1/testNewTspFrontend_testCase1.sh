#!/bin/bash

# Main test case function
testNewTspFrontend_testCase1() {
  local test_dir="$1"
  local project_dir="$test_dir/my-frontend-project"
  local package_json="$project_dir/package.json"

  echo "🎬 Test Case 1: Crafting a frontend masterpiece with --frontend! 🌐"

  cd "$test_dir"
  echo "🎨 Executing: newTsp my-frontend-project --frontend"
  newTsp my-frontend-project --frontend

  echo "👀 What's cookin' in $test_dir?"
  ls -la "$test_dir"

  # Array of files and directories to check
  local checks=(
    "$project_dir"
    "$package_json"
    "$project_dir/tsconfig.json"
    "$project_dir/src/frontend"
    "$project_dir/src/frontend/index.ts"
    "$project_dir/public"
    "$project_dir/public/index.html"
  )

  local all_checks_passed=true

  # Check for the existence of each file and directory
  for check in "${checks[@]}"; do
    if ! testNewTspFrontend_testCase1_check_exists "$check"; then
      all_checks_passed=false
    fi
  done

  if $all_checks_passed; then
    echo "✅ Huzzah! my-frontend-project is a beauty with --frontend! 🎉"

    cd "$project_dir"

    if testNewTspFrontend_testCase1_check_scripts "$package_json" &&
      testNewTspFrontend_testCase1_check_puppeteer; then
      echo "🎤 Scripts and Puppeteer are droppin' the mic! ✅"
      testNewTspFrontend_testCase1_check_main_absence "$package_json"
    else
      echo "❌ Yikes! Scripts or Puppeteer forgot their lines! 😱"
      jq '.scripts' "$package_json"
      return 1
    fi
  else
    echo "❌ Oh snap! my-frontend-project is a hot mess! 😵"
    ls -la "$project_dir"

    # Detective mode: what's missing? 🔍
    if ! testNewTspFrontend_testCase1_check_exists "$project_dir"; then echo "🏠 Project dir 'my-frontend-project' is a ghost town!"; fi

    if testNewTspFrontend_testCase1_check_exists "$project_dir"; then
      ! testNewTspFrontend_testCase1_check_exists "$package_json" && echo "📜 package.json bailed!"
      ! testNewTspFrontend_testCase1_check_exists "$project_dir/tsconfig.frontend.json" && echo "⚙️ tsconfig.frontend.json is MIA!"
      ! testNewTspFrontend_testCase1_check_exists "$project_dir/src/frontend" && echo "📁 src/frontend didn't show!"
      testNewTspFrontend_testCase1_check_exists "$project_dir/src/frontend" && ! testNewTspFrontend_testCase1_check_exists "$project_dir/src/frontend/index.ts" && echo "📝 index.ts flaked!"
      ! testNewTspFrontend_testCase1_check_exists "$project_dir/public" && echo "📂 public dir is lost!"
      testNewTspFrontend_testCase1_check_exists "$project_dir/public" && ! testNewTspFrontend_testCase1_check_exists "$project_dir/public/index.html" && echo "🌐 index.html is a no-show!"
    fi
    return 1
  fi
}