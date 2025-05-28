#!/bin/bash
testNewTsp_runCombinedTest() {
  echo ""
  echo "🎮 Combo breaker test GO! Node + Frontend = BOOM! 💥"
  echo "---------------------------------------------"
  testNewTspCombined
  local result=$?
  echo "---------------------------------------------"

  return $result
}
