#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_common() {
  local project_name="$1"

  echo "Setting up common project structure..."

  # Initialize npm
  newTsp_init_npm "$project_name"

  # Install common dependencies
  newTsp_install_deps

  # Initialize TypeScript
  newTsp_init_typescript

  # Create .gitignore
  newTsp_create_gitignore

  echo "Common setup completed."
}
