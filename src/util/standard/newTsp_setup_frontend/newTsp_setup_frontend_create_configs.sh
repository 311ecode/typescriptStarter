#!/bin/bash
newTsp_setup_frontend_create_configs() {
  echo "Creating configuration files..."
  
  cat > tsconfig.frontend.json << EOF
{
  "compilerOptions": {
    "target": "ESNext",
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": false,
    "skipLibCheck": true,
    "outDir": "public",
    "rootDir": "src",
    "sourceMap": true,
    "allowSyntheticDefaultImports": true,
    "baseUrl": ".",
    "jsx": "preserve"
  },
  "include": ["src/frontend/**/*"],
  "exclude": ["node_modules", "dist", "public"]
}
EOF

  cat > tsconfig.server.json << EOF
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": false,
    "skipLibCheck": true,
    "outDir": "dist",
    "sourceMap": true
  },
  "include": ["test/e2e/**/*"],
  "exclude": ["node_modules", "public"]
}
EOF

  cat << EOF > jest.config.frontend.js
// jest.config.frontend.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'jsdom',
  extensionsToTreatAsEsm: ['.ts', '.tsx'],
  moduleFileExtensions: ['tsx', 'ts', 'js', 'json', 'node'],
  modulePaths: ['../../node_modules/'],
  moduleDirectories: ['node_modules', '../../node_modules'],
  testMatch: [
    '**/test/frontend/**/*.ts?(x)',
    '**/test/frontend/?(*.)+(spec|test).ts?(x)'
  ],
  verbose: true,
};
EOF

  cat << EOF > jest.e2e.config.js
// jest.e2e.config.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts', '.tsx'],
  moduleFileExtensions: ['tsx', 'ts', 'js', 'json', 'node'],
  modulePaths: ['../../node_modules/'],
  moduleDirectories: ['node_modules', '../../node_modules'],
  testMatch: [
    '**/test/e2e/**/*.e2e.test.ts',
  ],
  verbose: true,
  transform: {
    '^.+\.ts(x?)$': [
      'ts-jest',
      {
        useESM: true,
        tsconfig: '<rootDir>/tsconfig.server.json',
      },
    ],
  },
  globalSetup: '<rootDir>/test/e2e/setup.ts',
};
EOF
}

