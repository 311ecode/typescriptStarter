#!/bin/bash
newTsp_init_npm() {
  npm init -y

  # Add the lines to package.json
  jq '. + {
    "main": "dest/src/index.js",
    "types": "dest/src/index.d.ts",
    "type": "module",
    "files": [
      "dest/src*/**"
    ]
  }' package.json > temp.json && mv temp.json package.json
}
