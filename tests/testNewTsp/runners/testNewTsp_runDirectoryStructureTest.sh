#!/bin/bash
testNewTsp_runDirectoryStructureTest() {
  echo ""
  echo "🏗️ Directory structure test marathon! Everything in its right place! 📂"
  echo "---------------------------------------------"
  testNewTspDirectoryStructure
  local result=$?
  echo "---------------------------------------------"
  
  return $result
}

