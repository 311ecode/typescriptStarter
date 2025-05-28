#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTspParseArgs() {
  local initial_dir=$(pwd)
  trap 'cd "$initial_dir"' EXIT

  # Create a temporary test directory
  local test_dir=$(mktemp -d -t test-XXXXXXXXXX)
  cd "$test_dir"

  echo "🧩 Kicking off the GREAT PARSER TEST BASH! 🎉"
  echo "🔍 Let’s see if we can decode those args like CHAMPS! 🏆"

  local all_tests_passed=true

  # Test case 1: Project name only
  echo "🎯 Test 1: Lone project name incoming!"
  local result=$(newTsp_parse_args "my-project")
  local expected="my-project false false false false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 1 ROCKED IT! High five! ✋"
  else
    echo "  💥 Test 1 tripped! Whoops!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 2: Project name with --typezero flag
  echo "🎯 Test 2: Project name + --typezero = FUN TIMES!"
  result=$(newTsp_parse_args "my-project" "--typezero")
  expected="my-project true false false false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 2 is a SUPERSTAR! 🎸"
  else
    echo "  💥 Test 2 fumbled! Oof!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 3: Project name with --node flag
  echo "🎯 Test 3: Project name + --node, let’s GO!"
  result=$(newTsp_parse_args "my-project" "--node")
  expected="my-project false true false false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 3 NAILED IT! Woo! 🚀"
  else
    echo "  💥 Test 3 crashed! Ouch!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 4: Project name with -n flag (shorthand for --node)
  echo "🎯 Test 4: Project name + -n shorthand, sneaky!"
  result=$(newTsp_parse_args "my-project" "-n")
  expected="my-project false true false false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 4 is a WINNER! 🏅"
  else
    echo "  💥 Test 4 slipped! Doh!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 5: Project name with multiple flags
  echo "🎯 Test 5: Multi-flag madness!"
  result=$(newTsp_parse_args "my-project" "--typezero" "--node")
  expected="my-project true true false false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 5 is a CHAMPION! 🥇"
  else
    echo "  💥 Test 5 flopped! Eek!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 6: Project name with help flag
  echo "🎯 Test 6: Project name + --help, show me the way!"
  result=$(newTsp_parse_args "my-project" "--help")
  expected="my-project false false false true"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 6 SHINES BRIGHT! ✨"
  else
    echo "  💥 Test 6 stumbled! Oops!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 7: Multiple flags in different orders
  echo "🎯 Test 7: Flag shuffle time!"
  result=$(newTsp_parse_args "--node" "my-project" "--typezero")
  expected="my-project true true false false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 7 danced through it! 💃"
  else
    echo "  💥 Test 7 got tangled! Yikes!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 8: Project name with --frontend flag
  echo "🎯 Test 8: Project name + --frontend, looking good!"
  result=$(newTsp_parse_args "my-project" "--frontend")
  expected="my-project false false true false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 8 is STYLIN’! 😎"
  else
    echo "  💥 Test 8 fell flat! Oh no!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 9: Project name with --frontend and --typezero flags
  echo "🎯 Test 9: Frontend + typezero combo!"
  result=$(newTsp_parse_args "my-project" "--frontend" "--typezero")
  expected="my-project true false true false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 9 is a POWER DUO! ⚡"
  else
    echo "  💥 Test 9 missed the mark! Oof!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 10: All flags including --frontend
  echo "🎯 Test 10: ALL FLAGS ON DECK! Epic finale!"
  result=$(newTsp_parse_args "my-project" "--typezero" "--node" "--frontend" "--help")
  expected="my-project true true true true"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 10 is LEGENDARY! 🎉"
  else
    echo "  💥 Test 10 didn’t make it! Wah!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 11: Project name with -nf flag (combined shorthand)
  echo "🎯 Test 11: Project name + -nf combined flag, double trouble!"
  result=$(newTsp_parse_args "my-project" "-nf")
  expected="my-project false true true false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 11 is a PERFECT COMBO! 🤜🤛"
  else
    echo "  💥 Test 11 fumbled the combo! Oof!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 12: Project name with -fn flag (combined shorthand in different order)
  echo "🎯 Test 12: Project name + -fn flag, reverse order combo!"
  result=$(newTsp_parse_args "my-project" "-fn")
  expected="my-project false true true false"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 12 mixed it up and won! 🎮"
  else
    echo "  💥 Test 12 got the order wrong! Darn!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Test case 13: Project name with -nfh flag (all shorthands combined)
  echo "🎯 Test 13: Project name + -nfh, the ultimate combo!"
  result=$(newTsp_parse_args "my-project" "-nfh")
  expected="my-project false true true true"

  if [[ $result == "$expected" ]]; then
    echo "  🌟 Test 13 got the MEGA COMBO! 🎯🎯🎯"
  else
    echo "  💥 Test 13 missed some flags! Oh no!"
    echo "    Expected: $expected"
    echo "    Got:      $result"
    all_tests_passed=false
  fi

  # Clean up and wrap up
  cd "$initial_dir"
  rm -rf "$test_dir"

  if $all_tests_passed; then
    echo "🎉 Parser tests are UNSTOPPABLE! Victory lap time! 🏃‍♂️"
    return 0
  else
    echo "😱 Some parser tests hit a snag! Time to debug! 🔍"
    return 1
  fi
}
