#!/bin/bash
testNewTspCombined_setup() {
  echo "🎉 Combo test extravaganza! Node + Frontend = Epic! 🚀"

  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-combo-test-XXXXXXXXXX)
  
  # Return the variables as a colon-separated string
  echo "$initial_dir:$test_dir"
}

