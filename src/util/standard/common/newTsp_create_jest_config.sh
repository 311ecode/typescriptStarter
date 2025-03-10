#!/bin/bash
newTsp_create_jest_config() {
  echo "Creating Jest test configuration..."
  
  # Create Jest config for Node.js tests
  cat << EOF > jest.config.node.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts'],
  moduleFileExtensions: ['ts', 'js', 'json', 'node'],
  transform: {
    '^.+\\.ts$': [
      'ts-jest',
      {
        useESM: true,
        tsconfig: './tsconfig.node.json'
      }
    ]
  },
  testMatch: [
    "**/test/backend/**/*.ts",
    "**/test/backend/**/*.test.ts"
  ],
  verbose: true
};
EOF

  # Base Jest config
  cat << EOF > jest.config.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
import nodeConfig from './jest.config.node.js';

export default {
  ...nodeConfig,
  // Add any overrides for the base config here
};
EOF

  echo "Jest configuration created successfully."
}