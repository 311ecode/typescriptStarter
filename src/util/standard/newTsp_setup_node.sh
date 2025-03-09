#!/bin/bash
newTsp_setup_node() {
  echo "Setting up Node.js backend..."
  
  # Install node-specific dependencies
  npm install --save-dev demeter-di
  
  # Configure TypeScript for Node.js
  npx tsc --init --moduleResolution bundler --module ES2015 --target es2022 --outDir dist \
          --strict false --declaration 
  
  # Rename the generated tsconfig.json to tsconfig.node.json
  mv tsconfig.json tsconfig.node.json
  
  # Create a base tsconfig.json that extends the node config
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

  # Create Jest configuration for Node.js
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
    "**/test/backend/**/*.ts?(x)",
    "**/test/backend/?(*.)+(spec|test).ts?(x)"
  ],
  verbose: true,
};
EOF

  # Create basic Jest config if it doesn't exist
  if [ ! -f "jest.config.js" ]; then
    cat << EOF > jest.config.js
// jest.config.js
import nodeConfig from './jest.config.node.js';

export default {
  ...nodeConfig,
  // Add any overrides for the base config here
};
EOF
  else
    # Update the Jest config to include the node config
    cat << EOF > jest.config.js.new
// jest.config.js
import nodeConfig from './jest.config.node.js';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);

// Import existing config if it exists
let existingConfig = {};
try {
  existingConfig = require('./jest.config.js');
} catch (e) {
  // No existing config, that's OK
}

export default {
  ...nodeConfig,
  ...existingConfig,
  // Ensure we can run both frontend and backend tests if needed
  projects: [
    ...(existingConfig.projects || []),
    '<rootDir>/jest.config.node.js',
  ],
};
EOF
    mv jest.config.js.new jest.config.js
  fi
  
  # Create Node.js source files
  mkdir -p src/backend
  touch src/backend/index.ts
  echo 'export const helloWorld = "Hello World!";

console.log("Hello World!");
' > src/backend/index.ts
  
  touch src/backend/math.ts
  echo 'export function add(a: number, b: number): number {
  return a + b;
}' > src/backend/math.ts

  # Create Node.js test files  
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
  
  # Add Node.js specific scripts to package.json
  jq '.scripts += {
    "tsart": "npx ts-node src/backend/index.ts",
    "start:backend": "node dist/backend/index.js",
    "test:backend": "npx jest --config jest.config.node.js --coverage",
    "build:backend": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap",
    "build:backend:watch": "tsup src/backend/index.ts --format esm,cjs --dts --clean --sourcemap --watch",
    "dev:backend": "tsup src/backend/index.ts --format esm,cjs --watch",
    "typecheck:backend": "tsc --project tsconfig.node.json"
  }' package.json > temp.json && mv temp.json package.json
  
  # Add Node.js specific configs to package.json if they don't exist
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
      },
      "type": "module"
    }' package.json > temp.json && mv temp.json package.json
  fi
  
  # Add combined test script if it doesn't exist
  if ! jq -e '.scripts.test' package.json > /dev/null 2>&1; then
    jq '.scripts += {
      "test": "npm run test:backend"
    }' package.json > temp.json && mv temp.json package.json
  else
    # Update test script to include backend tests
    existing_test=$(jq -r '.scripts.test' package.json)
    if [[ "$existing_test" != *"test:backend"* ]]; then
      jq --arg test "$existing_test && npm run test:backend" '.scripts.test = $test' package.json > temp.json && mv temp.json package.json
    fi
  fi
  
  # Add combined build script if it doesn't exist
  if ! jq -e '.scripts.build' package.json > /dev/null 2>&1; then
    jq '.scripts += {
      "build": "npm run build:backend"
    }' package.json > temp.json && mv temp.json package.json
  else
    # Update build script to include backend build
    existing_build=$(jq -r '.scripts.build' package.json)
    if [[ "$existing_build" != *"build:backend"* ]]; then
      jq --arg build "$existing_build && npm run build:backend" '.scripts.build = $build' package.json > temp.json && mv temp.json package.json
    fi
  fi
  
  echo "Node.js backend setup completed."
}