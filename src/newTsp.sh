#!/bin/bash

newTsp() {
  local newTsp_project_name=""
  local newTsp_typezero="false"
  local newTsp_node="false"
  local newTsp_frontend="false"
  local newTsp_help="false"

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

  mkdir -p "$newTsp_project_name"
  cd "$newTsp_project_name" || exit 1

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
}

