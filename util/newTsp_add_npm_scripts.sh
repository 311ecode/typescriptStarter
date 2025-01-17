#!/bin/bash

newTsp_add_npm_scripts() {
  jq '.scripts = { 
    "start": "npx ts-node src/index.ts", 
    "test": "npx jest --coverage", 
    "test:ci": "npx jest --ci --coverage",
    "build": "npx tsc", 
    "start:build": "npm run build && node dest/index.js",
    "dev": "npx ts-node-dev --respawn --transpileOnly src/index.ts"
    } 
  ' package.json > temp.json && mv temp.json package.json
}
