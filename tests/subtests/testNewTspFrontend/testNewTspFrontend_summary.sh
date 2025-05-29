#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspFrontend_summary() {
  local tests_run=$1
  local tests_passed=$2

  echo ""
  echo "🎲 Tests run: $tests_run"
  echo "🥇 Tests passed: $tests_passed"

  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "🌈 Frontend tests are a total win! Party time! 🎉"
    return 0
  else
    echo "😿 Some frontend tests crashed the party! Fix 'em up! 🔧"
    return 1
  fi
}
