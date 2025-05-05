#!/bin/bash
testNewTspNode_summary() {
  local tests_run=$1
  local tests_passed=$2

  echo ""
  echo "🎮 Tests run: $tests_run"
  echo "🏆 Tests passed: $tests_passed"

  if [ "$tests_passed" -eq "$tests_run" ]; then
    echo "🎉 All Node tests crushed it! High five! ✋"
    return 0
  else
    echo "😵 Some Node tests flopped! Time to debug! 🔧"
    return 1
  fi
}