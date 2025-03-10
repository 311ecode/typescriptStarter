#!/bin/bash

newTsp() {
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
      --node|-n)
        newTsp_node="true"
        shift
        ;;
      --frontend|-f)
        newTsp_frontend="true"
        shift
        ;;
      --help|-h)
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

  if [ "$newTsp_help" = "true" ]; then
    echo "Usage: newTsp <project_name> [--typezero] [--node|-n] [--frontend|-f] [--help|-h]"
    exit 0
  fi

  if [ -z "$newTsp_project_name" ]; then
    echo "Error: Project name is required."
    exit 1
  fi

  echo "Creating project: $newTsp_project_name"
  echo "Initial directory: $initial_dir"
  
  # Sanitize directory name without adding trailing dash
  local safe_dir_name=$(echo "$newTsp_project_name" | tr -c 'a-zA-Z0-9\-_.' '-' | sed 's/-*$//g')
  
  # Create project directory if it doesn't exist
  if [ ! -d "$safe_dir_name" ]; then
    mkdir -p "$safe_dir_name"
  fi
  
  # Change to project directory
  cd "$safe_dir_name" || {
    echo "Error: Failed to navigate to $safe_dir_name directory"
    exit 1
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