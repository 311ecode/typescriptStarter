#!/bin/bash
testNewTsp() {
  echo "🎉 Welcome to the ULTIMATE newTsp TEST EXTRAVAGANZA! 🌟"
  echo "🍿 Grab some popcorn, we’re testing EVERYTHING! 😎"
  
  # Scoreboard time! 🏆
  local total_tests=0
  local total_passed=0
  
  # Party lights on! 🎈
  echo ""
  echo "🧩 Parser party is HERE! Let's decode those args! 🎲"
  echo "---------------------------------------------"
  testNewTspParseArgs
  parse_result=$?
  total_tests=$((total_tests + 1))
  [ $parse_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "🌍 Calling the Node.js backend test crew! 🐢💻"
  echo "---------------------------------------------"
  testNewTspNode
  node_result=$?
  total_tests=$((total_tests + 1))
  [ $node_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "🌐 Time for the Frontend test fiesta! 🎨✨"
  echo "---------------------------------------------"
  testNewTspFrontend
  frontend_result=$?
  total_tests=$((total_tests + 1))
  [ $frontend_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "🎮 Combo breaker test GO! Node + Frontend = BOOM! 💥"
  echo "---------------------------------------------"
  testNewTspCombined
  combined_result=$?
  total_tests=$((total_tests + 1))
  [ $combined_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"
  
  echo ""
  echo "📦 Package name test extravaganza! Let's check those names! 🏷️"
  echo "---------------------------------------------"
  testNewTspPackageName
  package_name_result=$?
  total_tests=$((total_tests + 1))
  [ $package_name_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"

  echo ""
  echo "🏗️ Directory structure test marathon! Everything in its right place! 📂"
  echo "---------------------------------------------"
  testNewTspDirectoryStructure
  directory_structure_result=$?
  total_tests=$((total_tests + 1))
  [ $directory_structure_result -eq 0 ] && total_passed=$((total_passed + 1))
  echo "---------------------------------------------"

  # Grand finale! 🎤
  echo ""
  echo "🎷 Testapalooza wrap-up time! Let’s see the stats! 📊"
  echo "🎲 Total tests run: $total_tests"
  echo "🏅 Total tests passed: $total_passed"
  
  if [ "$total_passed" -eq "$total_tests" ]; then
    echo "🌈 WOOHOO! All tests are ROCKSTARS! Party time! 🎉🎸"
    echo "🎵 Cue the victory music! 🕺💃"
    return 0
  else
    echo "😿 Oh no! Some tests tripped over their shoelaces! 😅"
    echo "🔧 Time to debug—don’t worry, we’ll get ‘em next time! 💪"
    echo "Here’s the scoop:"
    [ $parse_result -ne 0 ] && echo "  ❌ Parser tests couldn’t crack the code!"
    [ $node_result -ne 0 ] && echo "  ❌ Node tests said ‘nope!’"
    [ $frontend_result -ne 0 ] && echo "  ❌ Frontend tests took a tumble!"
    [ $combined_result -ne 0 ] && echo "  ❌ Combo tests didn’t combo!"
    return 1
  fi
}
