#!/bin/bash
testNewTsp_runFrontendTest() {
  echo ""
  echo "🌐 Time for the Frontend test fiesta! 🎨✨"
  echo "---------------------------------------------"
  testNewTspFrontend
  local result=$?
  echo "---------------------------------------------"
  
  return $result
}

