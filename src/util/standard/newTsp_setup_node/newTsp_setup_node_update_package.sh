#!/bin/bash

newTsp_setup_node_update_package() {
  echo "Updating package.json for Node.js tests..."
  
  jq '.scripts |= .+ {
    "tsart": "npx ts-node src/backend/index.ts",
    "start:backend": "node dist/backend/index.js",
    "test:backend": "jest --config jest.config.node.js",
    "build:backend": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap",
    "build:backend:watch": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap --watch",
    "dev:backend": "tsup src/backend/index.ts --format esm,cjs --watch",
    "typecheck:backend": "tsc --project tsconfig.node.json --noEmit"
  }' package.json > temp.json && mv temp.json package.json

  echo "Package.json updated with Node.js test scripts."
}