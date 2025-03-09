#!/bin/bash


newTsp() {
  IFS=' ' read -r newTsp_project_name newTsp_typezero newTsp_node newTsp_frontend newTsp_help <<< "$(newTsp_parse_args "$@")"

  if [ "$newTsp_help" = "true" ]; then
    newTsp_help
    return 0
  fi

  if [ -z "$newTsp_project_name" ]; then
    echo "Error: Project name is required"
    echo "Use 'newTsp --help' for usage information"
    return 1
  fi

  if [ "$newTsp_typezero" = "true" ]; then
    # TypeZero takes precedence
    newTsp_typezero_init "$newTsp_project_name"
    return 0
  fi

  # Create the project directory and initialize common elements
  mkdir -p "$newTsp_project_name"
  cd "$newTsp_project_name" || exit

  # Initialize npm and install common dependencies
  newTsp_init_npm "$newTsp_project_name"
  newTsp_install_deps
  newTsp_create_gitignore

  # If no specific project type was selected, show selection menu
  if [ "$newTsp_node" = "false" ] && [ "$newTsp_frontend" = "false" ]; then
    project_type=$(newTsp_select_project_type)
    case "$project_type" in
      "node")
        newTsp_node=true
        ;;
      "frontend")
        newTsp_frontend=true
        ;;
      *)
        echo "$project_type"
        cd ..
        return 1
        ;;
    esac
  fi

  # Apply node and/or frontend specific setup based on flags
  if [ "$newTsp_node" = "true" ]; then
    newTsp_setup_node
  fi

  if [ "$newTsp_frontend" = "true" ]; then
    newTsp_setup_frontend
  fi

  # Set up the test script based on project types
  newTsp_setTestScript "$newTsp_node" "$newTsp_frontend"

  echo "
  Project initialized successfully at:
  "
  pwd
  cd ..
}