#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_reportNodeFailures() {
  local node_result=$1

  if [ $node_result -ne 0 ]; then
    echo "  ❌ NODE.JS TEST FAILURES:"
    echo "     - Node.js project setup encountered problems"
    echo "     - Check newTsp_setup_node and related functions"
    echo "     - Verify tsconfig.node.json and Jest configuration"
  fi
}
