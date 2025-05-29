#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

newTsp_init_npm() {
  local project_name="$1"
  echo "Initializing npm for $project_name..."

  # Debug current directory
  echo "  Current directory for npm init: $(pwd)"

  # Sanitize project name for npm (lowercase, replace special chars with hyphens)
  local sanitized_name=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9\-' '-' | sed 's/-*$//g')

  # Initialize npm project
  npm init -y >/dev/null 2>&1

  # Verify package.json was created
  if [ ! -f "package.json" ]; then
    echo "ERROR: package.json was not created by npm init. Creating manually."
    echo '{
  "name": "'$sanitized_name'",
  "version": "1.0.0",
  "description": "",
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "type": "module",
  "scripts": {},
  "keywords": [],
  "author": "",
  "license": "ISC",
    "files": [
    "dist/index.js",
    "dist/index.d.ts",
    "dist/index.js.map"
  ]
}' >package.json
  else
    # Update package.json with jq
    if command -v jq >/dev/null 2>&1; then
      # Remove trailing dash if present from sanitized name
      sanitized_name=$(echo "$sanitized_name" | sed 's/-*$//g')

      jq --arg name "$sanitized_name" '.name = $name | .type = "module" | del(.scripts.test)' package.json >temp.json
      if [ -f "temp.json" ]; then
        mv temp.json package.json
      else
        echo "ERROR: Failed to create temp.json when updating package.json"
      fi
    else
      echo "WARNING: jq is not installed. Using sed instead."
      # Fallback to sed if jq is not available
      sanitized_name=$(echo "$sanitized_name" | sed 's/-*$//g')
      sed -i 's/"name": "[^"]*"/"name": "'$sanitized_name'"/g' package.json
      sed -i 's/"type": "[^"]*"/"type": "module"/g' package.json
      if ! grep -q '"type":' package.json; then
        sed -i '/"license":/a\  "type": "module",' package.json
      fi
    fi
  fi

  # Verify the changes
  echo "  Verifying package.json contents:"
  if [ -f "package.json" ]; then
    grep -E '"name"|"type"' package.json
  else
    echo "  ERROR: package.json still doesn't exist after initialization!"
  fi
}
