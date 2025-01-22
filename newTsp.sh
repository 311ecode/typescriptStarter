#!/bin/bash
newTsp() {
  newTsp_create_project_dir "$1"
  newTsp_init_npm
  newTsp_install_deps
  newTsp_init_typescript
  newTsp_create_index_ts
  newTsp_create_gitignore
  
  echo "
  Project initialized successfully!
  "
}

