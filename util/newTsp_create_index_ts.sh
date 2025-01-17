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
  };" > jest.config.js 
}