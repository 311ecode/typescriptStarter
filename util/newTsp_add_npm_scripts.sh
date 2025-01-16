#!/bin/bash
newTsp_add_npm_scripts() {
  npm set-script start "ts-node src/index.ts"
  npm set-script test "jest"
  npm set-script build "tsc"
  npm set-script start:build "npm run build && node dest/index.js"
  npm set-script dev "npx ts-node-dev --respawn --transpileOnly src/index.ts" 
}