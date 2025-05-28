#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_runParserTest() {
  echo ""
  echo "🧩 Parser party is HERE! Let's decode those args! 🎲"
  echo "---------------------------------------------"
  testNewTspParseArgs
  local result=$?
  echo "---------------------------------------------"

  return $result
}
