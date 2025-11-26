#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp() {
  command -v markdown-show-help-registration &>/dev/null && eval "$(markdown-show-help-registration -m 1)"
  local newTsp_project_name=""
  local newTsp_typezero="false"
  local newTsp_node="false"
  local newTsp_frontend="false"
  local newTsp_help="false"
  local initial_dir=$(pwd)

  # Parse arguments
  while [ $# -gt 0 ]; do
    case "$1" in
    --typezero)
      newTsp_typezero="true"
      shift
      ;;
    --node | -n)
      newTsp_node="true"
      shift
      ;;
    --frontend | -f)
      newTsp_frontend="true"
      shift
      ;;
    --help | -h)
      newTsp_help="true"
      shift
      ;;
    *)
      if [ -z "$newTsp_project_name" ]; then
        newTsp_project_name="$1"
      else
        echo "Error: Multiple project names provided or unrecognized argument: $1"
        exit 1
      fi
      shift
      ;;
    esac
  done

  # Check for help flag FIRST and exit immediately if present
  if [ "$newTsp_help" = "true" ]; then
    # Call the detailed help function instead of just showing usage
    newTsp_help
    command -v markdown-show-help-registration &>/dev/null && eval "$(markdown-show-help-registration -m 1)"

    return 0 # Use return instead of exit when in a function
  fi

  if [ -z "$newTsp_project_name" ]; then
    echo "Error: Project name is required."
    echo "Run 'newTsp --help' for usage information."
    return 1 # Use return instead of exit when in a function
  fi

  echo "Creating project: $newTsp_project_name"
  echo "Initial directory: $initial_dir"

  # After (add lowercase conversion)
  local safe_dir_name=$(echo "$newTsp_project_name" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9\-_.' '-' | sed 's/-*$//g')

  # Create project directory if it doesn't exist
  if [ ! -d "$safe_dir_name" ]; then
    mkdir -p "$safe_dir_name"
  fi

  # Change to project directory
  cd "$safe_dir_name" || {
    echo "Error: Failed to navigate to $safe_dir_name directory"
    return 1 # Use return instead of exit when in a function
  }

  echo "Project directory: $(pwd)"

  # Initialize common setup
  newTsp_setup_common "$newTsp_project_name"

  # Apply setups, merging scripts
  if [ "$newTsp_node" = "true" ]; then
    newTsp_setup_node
  fi
  if [ "$newTsp_frontend" = "true" ]; then
    newTsp_setup_frontend
  fi

  # Finalize test script
  newTsp_setTestScript "$newTsp_node" "$newTsp_frontend"

  echo "
  Project initialized successfully at:
  "
  pwd
  echo "✨ Happy coding! Time to make something awesome! 🚀"

  # Return to initial directory
  cd "$initial_dir" || echo "Warning: Could not return to initial directory"
}

registerToFunctionsDB
