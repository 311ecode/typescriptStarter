#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_parse_args() {
  local args=("$@")
  local project_name=""
  local typezero=false
  local node=false
  local help=false
  local frontend=false

  for arg in "${args[@]}"; do
    if [[ $arg =~ ^-- ]]; then
      # Handle --flags
      if [[ $arg == "--typezero" ]]; then
        typezero=true
      elif [[ $arg == "--node" ]]; then
        node=true
      elif [[ $arg == "--frontend" ]]; then
        frontend=true
      elif [[ $arg == "--help" ]]; then
        help=true
      fi
    elif [[ $arg =~ ^- ]]; then
      # Handle combined flags like -nf, -fn, -h, etc.
      if [[ $arg == "-h" ]]; then
        help=true
      else
        # Process each character in the flag
        for ((i = 1; i < ${#arg}; i++)); do
          local flag="${arg:i:1}"
          if [[ $flag == "n" ]]; then
            node=true
          elif [[ $flag == "f" ]]; then
            frontend=true
          elif [[ $flag == "h" ]]; then
            help=true
          fi
        done
      fi
    else
      # Handle project name (non-flag argument)
      if [ -z "$project_name" ]; then
        project_name="$arg"
      fi
    fi
  done

  # Debugging: Print parsed values
  echo "Debug: project_name=$project_name, typezero=$typezero, node=$node, frontend=$frontend, help=$help" >&2

  # Return parsed values
  echo "$project_name" "$typezero" "$node" "$frontend" "$help"
}
