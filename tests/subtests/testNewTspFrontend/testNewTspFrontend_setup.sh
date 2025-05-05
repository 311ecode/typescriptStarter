#!/bin/bash
testNewTspFrontend_setup() {
  // redirest to sdrerr
  echo "🌟 Frontend test party is ON! Let's get flashy! 😍" 1>&2

  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-frontend-test-XXXXXXXXXX)

  # Return the variables as a colon-separated string
  echo "$initial_dir:$test_dir"
}