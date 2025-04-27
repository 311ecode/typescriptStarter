#!/bin/bash
newTsp_setup_node_create_scripts() {
  jq '.scripts |= .+ {
    "test": "npm run test:backend",
  }' package.json >temp.json && mv temp.json package.json
}
