newTsp_create_index_ts() {
  mkdir src
  touch src/index.ts
  echo 'console.log("Hello World!");' > src/index.ts
  touch src/math.ts
  echo 'export function add(a: number, b: number): number {
    return a + b;
  }' > src/math.ts

  mkdir test
  touch test/math.test.ts
  echo "import { add } from '../src/math';

  test('add function should return the sum of two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });" > test/math.test.ts

  touch jest.config.js
  echo "/** @type {import('ts-jest').JestConfigWithTsJest} */
  module.exports = {
    preset: 'ts-jest',
    testEnvironment: 'node',
    coverageThreshold: {
      global: {
        branches: 80,
        functions: 80,
        lines: 80,
        statements: 80,
      },
    },
  };" > jest.config.js 

  touch README.md
  echo "# $(basename "\$PWD") 

This is a simple TypeScript project.

## Installation

1. Clone this repository.
2. Install dependencies using npm:
   \`\`\`
   npm install
   \`\`\`

## Usage

1. To run the project in development mode:
   \`\`\`
   npm run dev
   \`\`\`
2. To build the project:
   \`\`\`
   npm run build
   \`\`\`
3. To run the built project:
   \`\`\`
   npm run start:build
   \`\`\`
4. To run the tests:
   \`\`\`
   npm run test
   \`\`\`

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
" > README.md

  # Add ESLint and Prettier configuration files
  touch .eslintrc.js
  echo '{
      "extends": ["standard"],
      "parserOptions": {
        "project": "./tsconfig.json"
      }
  }' > .eslintrc.js
  touch .prettierrc.js
  echo '{
    "printWidth": 80,
    "tabWidth": 2,
    "useTabs": false,
    "semi": false,
    "singleQuote": true,
    "trailingComma": "es5",
    "bracketSpacing": true,
    "arrowParens": "always",
    "endOfLine": "lf"
  }' > .prettierrc.js
}