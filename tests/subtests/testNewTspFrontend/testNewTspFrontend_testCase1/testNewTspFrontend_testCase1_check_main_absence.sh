#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspFrontend_testCase1_check_main_absence() {
  local package_json="$1"
  if jq 'has("main")' "$package_json" | grep -q 'true'; then
    echo "❌ Yikes! $package_json has a 'main' key, which is unexpected! 😱"
    jq '.main' "$package_json"
    return 1
  else
    echo "✅ 'main' key is correctly absent. Bravo! 👏"
    return 0
  fi
}
