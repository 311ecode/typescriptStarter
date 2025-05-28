#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_runPackageNameTest() {
  echo ""
  echo "📦 Package name test extravaganza! Let's check those names! 🏷️"
  echo "---------------------------------------------"
  testNewTspPackageName
  local result=$?
  echo "---------------------------------------------"

  return $result
}
