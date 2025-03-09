#!/bin/bash
newTsp_typezero_init() {
  local folder_name="$1"
  
  mkdir "$folder_name"
  cd "$folder_name" || exit
  
  # Clone the full repository to the folder
  git clone git@github.com:mislam/typezero.git .
  
  # Remove the .git directory after cloning
  rm -rf .git

  # Update package.json name
  if [ -f "package.json" ]; then
    jq --arg name "$folder_name" '.name = $name' package.json > temp.json && mv temp.json package.json
  fi

  echo "
  Project initialized successfully with TypeZero!
  "
}

