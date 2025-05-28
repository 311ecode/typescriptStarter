#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspFrontend_testCase1_check_puppeteer() {
  if npm list puppeteer --depth=0 >/dev/null 2>&1; then
    echo "✅ Puppeteer is installed."
    return 0
  else
    echo "❌ Puppeteer is not installed."
    return 1
  fi
}
