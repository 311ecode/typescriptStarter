#!/bin/bash
newTsp_setup_node_update_package() {
  echo "Updating package.json..."
  
  jq '.scripts |= .+ {
    "tsart": "npx ts-node src/backend/index.ts",
    "start:backend": "node dist/backend/index.js",
    "test:backend": "jest --config jest.config.node.js --coverage",
    "build:backend": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap",
    "build:backend:watch": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap --watch",
    "dev:backend": "tsup src/backend/index.ts --format esm,cjs --watch",
    "typecheck:backend": "tsc --project tsconfig.node.json"
  }' package.json > temp.json && mv temp.json package.json

  if ! jq -e '.main' package.json > /dev/null 2>&1; then
    jq '. += {
      "main": "dist/backend/index.cjs",
      "module": "dist/backend/index.js",
      "types": "dist/backend/index.d.ts",
      "exports": {
        ".": {
          "require": "./dist/backend/index.cjs",
          "import": "./dist/backend/index.js",
          "types": "./dist/backend/index.d.ts"
        }
      }
    }' package.json > temp.json && mv temp.json package.json
  fi
}

