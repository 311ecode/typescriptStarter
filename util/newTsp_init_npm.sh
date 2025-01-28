#!/bin/bash
newTsp_init_npm() {
  npm init -y

  # Add the lines to package.json
  jq '. + {
    "main": "dist/index.js",
    "types": "dist/index.d.ts",
    "type": "module",
    "files": [
      "dist/**"
    ]
  }' package.json > temp.json && mv temp.json package.json

  jq '.scripts = {
    "tsart": "npx ts-node src/index.ts",
    "start": "node dist/index.js",
    "test": "npx jest --coverage",
    "test:ci": "npx jest --ci --coverage",
    "build": "tsup src/index.ts --format esm,cjs --dts --clean --sourcemap",
    "dev": "tsup src/index.ts --format esm,cjs --watch",
    "start:build": "npm run build && node dest/index.js",
    "dev": "npx ts-node-dev --respawn --transpileOnly src/index.ts",
    "lint": "ts-standard",
    "lint:fix": "ts-standard --fix",
    "format": "prettier --write src/**/*.ts",
    "typecheck": "tsc",
    "watch": "tsc --watch" 
  }' package.json > temp.json && mv temp.json package.json

}
