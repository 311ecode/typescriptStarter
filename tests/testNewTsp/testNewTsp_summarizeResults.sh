#!/bin/bash
testNewTsp_summarizeResults() {
  local total_tests=$1
  local total_passed=$2
  local initial_dir=$3
  local parse_result=$4
  local node_result=$5
  local frontend_result=$6
  local combined_result=$7
  local package_name_result=$8
  local directory_structure_result=$9
  
  # Grand finale! 🎤
  echo ""
  echo "🎷 Testapalooza wrap-up time! Let's see the stats! 📊"
  echo "🎲 Total tests run: $total_tests"
  echo "🏅 Total tests passed: $total_passed"

  cd "$initial_dir"

  if [ "$total_passed" -eq "$total_tests" ]; then
    echo "🌈 WOOHOO! All tests are ROCKSTARS! Party time! 🎉🎸"
    echo "🎵 Cue the victory music! 🕺💃"
    return 0
  else
    echo "😿 Oh no! Some tests tripped over their shoelaces! 😅"
    echo "🔧 Time to debug—don't worry, we'll get 'em next time! 💪"
    echo "Here's the detailed failure report:"
    
    testNewTsp_reportParserFailures $parse_result
    testNewTsp_reportNodeFailures $node_result
    testNewTsp_reportFrontendFailures $frontend_result
    testNewTsp_reportCombinedFailures $combined_result
    testNewTsp_reportPackageNameFailures $package_name_result
    testNewTsp_reportDirectoryStructureFailures $directory_structure_result
    
    return 1
  fi
}

