newTsp_create_jest_config() {
  # Create the node-specific Jest config
  cat << EOF > jest.config.node.js
// jest.config.node.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts'], // Only treat .ts files as ESM
  moduleFileExtensions: ['ts', 'js', 'json', 'node'], // Remove .tsx and .jsx
  modulePaths: ["../../node_modules/"], // Point to the root node_modules
  moduleDirectories: ["node_modules", "../../node_modules"],
  testMatch: [
    "**/test/**/*.ts?(x)",
    "**/?(*.)+(spec|test).ts?(x)"
  ],
  verbose: true,
};
EOF

  # Create a base Jest config that imports the node config
  cat << EOF > jest.config.js
// jest.config.js
import nodeConfig from './jest.config.node.js';

export default {
  ...nodeConfig,
  // Add any overrides for the base config here
};
EOF
}
