#!/bin/bash
testNewTspNode_setup() {
  echo "🚀 Launching Node.js backend tests! Buckle up! 😎"
  
  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-node-test-XXXXXXXXXX)
  
  # Return the variables as a colon-separated string
  echo "$initial_dir:$test_dir"
}

