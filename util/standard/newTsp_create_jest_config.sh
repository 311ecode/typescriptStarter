newTsp_create_jest_config() {
cat << EOF > jest.config.js
// jest.config.js
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
}