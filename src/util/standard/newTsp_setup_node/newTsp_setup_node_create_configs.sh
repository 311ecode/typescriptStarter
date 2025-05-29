#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_node_create_configs() {
  echo "Creating configuration files..."

  npx tsc --init --moduleResolution bundler --module ES2015 --target es2022 --outDir dist \
    --strict false --declaration

  if [ -f "tsconfig.json" ]; then
    mv tsconfig.json tsconfig.node.json
  else
    echo "Error: tsconfig.json was not created by tsc --init. Aborting."
    exit 1
  fi

  cat >tsconfig.json <<EOF
{
  "extends": "./tsconfig.node.json",
  "compilerOptions": {
    "outDir": "dist"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOF

}
