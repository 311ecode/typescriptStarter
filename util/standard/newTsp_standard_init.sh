#!/bin/bash
newTsp_standard_init() {
  local folder_name="$1"

  mkdir "$folder_name"
  cd "$folder_name" || exit

  newTsp_init_npm "$folder_name"
  newTsp_install_deps
  newTsp_init_typescript
  newTsp_create_index_ts
  newTsp_create_gitignore

  echo "
  Project initialized successfully!
  "
}

