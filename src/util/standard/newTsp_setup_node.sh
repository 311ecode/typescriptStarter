#!/bin/bash
newTsp_setup_node() {
  echo "Setting up Node.js backend..."

  # Install TypeScript and demeter-di upfront
  npm install --save-dev typescript demeter-di

  # Now tsc should work via npx
  npx tsc --init --moduleResolution bundler --module ES2015 --target es2022 --outDir dist \
          --strict false --declaration

  # Check if tsconfig.json was created before moving
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

  mkdir -p src/backend
  touch src/backend/index.ts
  echo 'export const helloWorld = "Hello World!";

console.log("Hello World!");
' > src/backend/index.ts

  touch src/backend/math.ts
  echo 'export function add(a: number, b: number): number {
  return a + b;
}' > src/backend/math.ts

  mkdir -p test/backend
  touch test/backend/index.test.ts
  echo "import { helloWorld } from '../../src/backend/index';

test('helloWorld constant should be \"Hello World!\"', () => {
    expect(helloWorld).toBe('Hello World!');
});" > test/backend/index.test.ts

  touch test/backend/math.test.ts
  echo "import { add } from '../../src/backend/math';

test('add function should return the sum of two numbers', () => {
    expect(add(2, 3)).toBe(5);
});" > test/backend/math.test.ts

  # Merge backend scripts into package.json
  jq '.scripts |= .+ {
    "tsart": "npx ts-node src/backend/index.ts",
    "start:backend": "node dist/backend/index.js",
    "test:backend": "jest --config jest.config.node.js --coverage",
    "build:backend": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap",
    "build:backend:watch": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap --watch",
    "dev:backend": "tsup src/backend/index.ts --format esm,cjs --watch",
    "typecheck:backend": "tsc --project tsconfig.node.json"
  }' package.json > temp.json && mv temp.json package.json

  if ! jq -e '.main' package.json > /dev/null 2>&1; then
    jq '. += {
      "main": "dist/backend/index.cjs",
      "module": "dist/backend/index.js",
      "types": "dist/backend/index.d.ts",
      "exports": {
        ".": {
          "require": "./dist/backend/index.cjs",
          "import": "./dist/backend/index.js",
          "types": "./dist/backend/index.d.ts"
        }
      }
    }' package.json > temp.json && mv temp.json package.json
  fi

  echo "Node.js backend setup completed."
}
