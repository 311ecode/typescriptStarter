#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_runFrontendTest() {
  echo ""
  echo "🌐 Time for the Frontend test fiesta! 🎨✨"
  echo "---------------------------------------------"
  testNewTspFrontend
  local result=$?
  echo "---------------------------------------------"

  return $result
}
