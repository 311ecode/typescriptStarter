#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_reportCombinedFailures() {
  local combined_result=$1

  if [ $combined_result -ne 0 ]; then
    echo "  ❌ COMBO TEST FAILURES:"
    echo "     - Combined Node.js + Frontend setup not working"
    echo "     - Check interactions between different setup functions"
    echo "     - Verify concurrently is installed and scripts are combined"
  fi
}
