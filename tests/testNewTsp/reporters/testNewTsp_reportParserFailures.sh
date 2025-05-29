#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
testNewTsp_reportParserFailures() {
  local parse_result=$1

  if [ $parse_result -ne 0 ]; then
    echo "  ❌ PARSER TEST FAILURES:"
    echo "     - Command line argument handling is not working correctly"
    echo "     - Check the newTsp_parse_args function for issues"
  fi
}
