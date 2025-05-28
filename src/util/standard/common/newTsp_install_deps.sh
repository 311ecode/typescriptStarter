#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_install_deps() {
  npm install --save-dev typescript ts-node jest @types/jest ts-jest \
    eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin \
    prettier ts-standard tsup tsx
}
