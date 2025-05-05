#!/bin/bash
testNewTsp_runNodeTest() {
  echo ""
  echo "🌍 Calling the Node.js backend test crew! 🐢💻"
  echo "---------------------------------------------"
  testNewTspNode
  local result=$?
  echo "---------------------------------------------"

  return $result
}