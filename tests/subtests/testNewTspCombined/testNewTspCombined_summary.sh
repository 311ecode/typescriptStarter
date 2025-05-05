#!/bin/bash
testNewTspCombined_summary() {
  local tests_run=$1
  local tests_passed=$2

  echo ""
  echo "🎲 Tests run: $tests_run"
  echo "🥇 Tests passed: $tests_passed"

  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "🎉 Combo tests are a SMASH HIT! Victory dance! 💃🕺"
    return 0
  else
    echo "😿 Combo tests took a hit! Back to the dojo! 🥋"
    return 1
  fi
}