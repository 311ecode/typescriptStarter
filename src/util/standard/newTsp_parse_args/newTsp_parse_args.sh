#!/bin/bash
newTsp_parse_args() {
  local args=("$@")
  local project_name=""
  local typezero=false
  local node=false
  local help=false
  local frontend=false

  for arg in "${args[@]}"; do
    if [[ "$arg" =~ ^-- ]]; then
      # Handle --flags
      if [[ "$arg" == "--typezero" ]]; then
        typezero=true
      elif [[ "$arg" == "--node" ]]; then
        node=true
      elif [[ "$arg" == "--frontend" ]]; then
        frontend=true
      elif [[ "$arg" == "--help" ]]; then
        help=true
      fi
    elif [[ "$arg" =~ ^- ]]; then
      # Handle -flags
      if [[ "$arg" == "-n" ]]; then
        node=true
      elif [[ "$arg" == "-h" ]]; then
        help=true
      fi
    else
      # Handle project name (non-flag argument)
      if [ -z "$project_name" ]; then
        project_name="$arg"
      fi
    fi
  done

  # Debugging: Print parsed values
  echo "Debug: project_name=$project_name, typezero=$typezero, node=$node, help=$help" >&2

  # Return parsed values
  echo "$project_name" "$typezero" "$node" "$frontend" "$help" 
}

