#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_reportFrontendFailures() {
  local frontend_result=$1

  if [ $frontend_result -ne 0 ]; then
    echo "  ❌ FRONTEND TEST FAILURES:"
    echo "     - Frontend project setup encountered problems"
    echo "     - Check newTsp_setup_frontend and related functions"
    echo "     - Verify tsconfig.frontend.json and test setup"
  fi
}
