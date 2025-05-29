#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_create_project_dir() {
  local dir_name="$1"

  # Sanitize directory name but DON'T add a trailing dash
  local safe_dir_name=$(echo "$dir_name" | tr -c 'a-zA-Z0-9\-_.' '-' | sed 's/-*$//g')

  echo "Creating project directory: $dir_name (sanitized: $safe_dir_name)"

  # Create directory if it doesn't exist
  if [ ! -d "$safe_dir_name" ]; then
    mkdir -p "$safe_dir_name"
  fi

  # Navigate to the directory and verify
  cd "$safe_dir_name" || {
    echo "ERROR: Failed to navigate to $safe_dir_name directory"
    exit 1
  }

  # Verify current directory
  current_dir=$(basename "$(pwd)")
  echo "Successfully created and navigated to directory: $current_dir"
}
