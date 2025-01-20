#!/bin/bash

newTsp_add_npm_scripts() {
  jq '.scripts = {
    "tsart": "npx ts-node src/index.ts",
    "start": "node dist/index.js",
    "test": "npx jest --coverage",
    "test:ci": "npx jest --ci --coverage",
    "build": "npx tsc",
    "start:build": "npm run build && node dest/index.js",
    "dev": "npx ts-node-dev --respawn --transpileOnly src/index.ts",
    "lint": "ts-standard",
    "lint:fix": "ts-standard --fix",
    "format": "prettier --write src/**/*.ts",
    "typecheck": "tsc",
    "watch": "tsc --watch" 
  } | . + { "files": ["dest/src*"] }' package.json > temp.json && mv temp.json package.json
}
