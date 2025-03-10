#!/bin/bash
testNewTsp_runPackageNameTest() {
  echo ""
  echo "📦 Package name test extravaganza! Let's check those names! 🏷️"
  echo "---------------------------------------------"
  testNewTspPackageName
  local result=$?
  echo "---------------------------------------------"
  
  return $result
}

