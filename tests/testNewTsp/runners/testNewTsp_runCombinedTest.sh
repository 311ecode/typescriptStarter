#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_runCombinedTest() {
  echo ""
  echo "🎮 Combo breaker test GO! Node + Frontend = BOOM! 💥"
  echo "---------------------------------------------"
  testNewTspCombined
  local result=$?
  echo "---------------------------------------------"

  return $result
}
