#!/bin/bash
testNewTsp_runParserTest() {
  echo ""
  echo "🧩 Parser party is HERE! Let's decode those args! 🎲"
  echo "---------------------------------------------"
  testNewTspParseArgs
  local result=$?
  echo "---------------------------------------------"

  return $result
}
