#!/bin/bash

newTsp_init_npm() {
  local project_name="$1"
  echo "Initializing npm for $project_name..."
  npm init -y > /dev/null 2>&1
  jq --arg name "$project_name" '.name = $name | .type = "module" | del(.scripts.test)' package.json > temp.json && mv temp.json package.json
}
