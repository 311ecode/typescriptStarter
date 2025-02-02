#!/bin/bash
newTsp_parse_args() {
  local args=("$@")
  local project_name=""
  local typezero=false

  for arg in "${args[@]}"; do
    if [[ "$arg" =~ ^-- ]]; then
      if [[ "$arg" == "--typezero" ]]; then
        typezero=true
      fi
    else
      if [ -z "$project_name" ]; then
        project_name="$arg"
      fi
    fi
  done

  echo "$project_name" "$typezero"
}

