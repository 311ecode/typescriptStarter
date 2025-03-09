#!/bin/bash
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

  cat > tsconfig.json << EOF
{
  "extends": "./tsconfig.node.json",
  "compilerOptions": {
    "outDir": "dist"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOF

  cat << EOF > jest.config.node.js
// jest.config.node.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts'],
  moduleFileExtensions: ['ts', 'js', 'json', 'node'],
  modulePaths: ["../../node_modules/"],
  moduleDirectories: ["node_modules", "../../node_modules"],
  testMatch: [
    "**/test/backend/**/*.ts?(x)",
    "**/test/backend/?(*.)+(spec|test).ts?(x)"
  ],
  verbose: true,
};
EOF
}

