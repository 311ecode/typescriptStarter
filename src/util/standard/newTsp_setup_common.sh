#!/bin/bash
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
