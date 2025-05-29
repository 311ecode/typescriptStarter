#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_node_create_scripts() {
  jq '.scripts |= .+ {
    "test": "npm run test:backend",
  }' package.json >temp.json && mv temp.json package.json
}
