#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspCombined_setup() {
  echo "🎉 Combo test extravaganza! Node + Frontend = Epic! 🚀"

  local initial_dir=$(pwd)
  local test_dir=$(mktemp -d -t newTsp-combo-test-XXXXXXXXXX)

  # Return the variables as a colon-separated string
  echo "$initial_dir:$test_dir"
}
