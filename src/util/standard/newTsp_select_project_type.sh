#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
#
# Fixed newTsp function with proper parameter handling
#

# Function to display project type selection menu
newTsp_select_project_type() {
  echo ""
  echo "Select project type:"
  echo "1) Node.js Backend (TypeScript)"
  echo "2) [Coming Soon] Frontend (TypeScript)"
  echo "3) [Coming Soon] Full-Stack (TypeScript Frontend + Backend)"
  echo ""
  read -p "Enter selection (1-3): " selection

  case $selection in
  1)
    echo "node"
    ;;
  2)
    echo "Error: Frontend project type is not yet implemented"
    exit 1
    ;;
  3)
    echo "Error: Full-Stack project type is not yet implemented"
    exit 1
    ;;
  *)
    echo "Invalid selection. Please try again."
    newTsp_select_project_type
    ;;
  esac
}
