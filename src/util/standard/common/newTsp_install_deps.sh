#!/bin/bash
newTsp_install_deps() {
  npm install --save-dev typescript ts-node jest @types/jest ts-jest \
    eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin \
    prettier ts-standard tsup tsx
}