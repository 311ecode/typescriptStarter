#!/bin/bash
newTsp_create_index_ts() {
  mkdir src
  touch src/index.ts
  echo 'export const helloWorld = "Hello World!";' > src/index.ts  
  echo -e '\nconsole.log("Hello World!");\n' >> src/index.ts 
  
  touch src/math.ts
  echo 'export function add(a: number, b: number): number {
    return a + b;
  }' > src/math.ts

  mkdir test
  touch test/index.test.ts # Separate test file for index.ts
  echo "import { helloWorld } from '../src/index';  // Import helloWorld for testing

test('helloWorld constant should be \"Hello World!\"', () => {
    expect(helloWorld).toBe('Hello World!');
});" > test/index.test.ts

  touch test/math.test.ts # Separate test file for math.ts
  echo "import { add } from '../src/math';

test('add function should return the sum of two numbers', () => {
    expect(add(2, 3)).toBe(5);
});" > test/math.test.ts 
}