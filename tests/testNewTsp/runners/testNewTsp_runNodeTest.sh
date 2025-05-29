#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_runNodeTest() {
  echo ""
  echo "🌍 Calling the Node.js backend test crew! 🐢💻"
  echo "---------------------------------------------"
  testNewTspNode
  local result=$?
  echo "---------------------------------------------"

  return $result
}
