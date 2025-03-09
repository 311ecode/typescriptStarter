#!/bin/bash

newTsp_setTestScript() {
  local newTsp_node="$1"
  local newTsp_frontend="$2"

  # If both node and frontend are initialized, install concurrently and set up combined test script
  if [ "$newTsp_node" = "true" ] && [ "$newTsp_frontend" = "true" ]; then
    echo "Both Node.js and Frontend detected! Installing 'concurrently' for awesome test running..."
    npm install --save-dev concurrently

    # Add a combined test script using concurrently
    jq '.scripts += {
      "test": "concurrently --kill-others-on-fail \"npm run test:backend\" \"npm run test:frontend\""
    }' package.json > temp.json && mv temp.json package.json
  elif [ "$newTsp_node" = "true" ]; then
    # Only node, set test to backend
    jq '.scripts += {
      "test": "npm run test:backend"
    }' package.json > temp.json && mv temp.json package.json
  elif [ "$newTsp_frontend" = "true" ]; then
    # Only frontend, set test to frontend
    jq '.scripts += {
      "test": "npm run test:frontend"
    }' package.json > temp.json && mv temp.json package.json
  fi
}