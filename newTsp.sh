#!/bin/bash
newTsp(){
  IFS=' ' read -r project_name typezero <<< "$(newTsp_parse_args "$@")"

  if [ "$typezero" = "true" ]; then
    newTsp_typezero_init "$project_name"
  else
    newTsp_standard_init "$project_name"
  fi
}

