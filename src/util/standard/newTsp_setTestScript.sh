#!/bin/bash

newTsp_setTestScript() {
  local newTsp_node="$1"
  local newTsp_frontend="$2"

  if [ "$newTsp_node" = "true" ] && [ "$newTsp_frontend" = "true" ]; then
    echo "Both Node.js and Frontend detected! Ensuring 'concurrently' is ready..."
    npm install --save-dev concurrently
    jq '.scripts |= .+ {
      "test": "concurrently --kill-others-on-fail \"npm run test:backend\" \"npm run test:frontend\" \"npm run test:e2e\""
    }' package.json > temp.json && mv temp.json package.json
  elif [ "$newTsp_node" = "true" ]; then
    jq '.scripts |= .+ { "test": "npm run test:backend" }' package.json > temp.json && mv temp.json package.json
  elif [ "$newTsp_frontend" = "true" ]; then
    jq '.scripts |= .+ { "test": "concurrently --kill-others-on-fail \"npm run test:frontend\" \"npm run test:e2e\"" }' package.json > temp.json && mv temp.json package.json
  fi
}
