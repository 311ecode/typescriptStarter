#!/bin/bash
newTsp_init_npm() {
  npm init -y

  # Add the lines to package.json
  jq '. + {
    "main": "dist/index.cjs",
    "module": "dist/index.js",
    "types": "dist/index.d.ts",
    "exports": {
      ".": {
        "require": "./dist/index.cjs",
        "import": "./dist/index.js",
        "types": "./dist/index.d.ts"
      }
    },
    "type": "module",
    "files": [
      "dist/**"
    ]
  }' package.json > temp.json && mv temp.json package.json

  # Set the scripts in package.json.  Using a single jq command is more efficient.
  jq '.scripts = {
    "tsart": "npx ts-node src/index.ts",
    "start": "node dist/index.js",
    "test": "npx jest --coverage",
    "test:ci": "npx jest --ci --coverage",
    "build": "tsup src/index.ts --format esm,cjs --dts --clean --sourcemap",
    "build:watch": "tsup src/index.ts --format esm,cjs --dts --clean --sourcemap --watch",
    "dev": "tsup src/index.ts --format esm,cjs --watch",
    "lint": "ts-standard",
    "lint:fix": "ts-standard --fix",
    "format": "prettier --write src/**/*.ts",
    "typecheck": "tsc",
    "watch": "tsc --watch"
  }' package.json > temp.json && mv temp.json package.json
}