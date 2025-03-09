#!/bin/bash
newTsp_setup_node_create_tests() {
  echo "Creating backend test files..."
  
  echo "import { helloWorld } from '../../src/backend/index';

test('helloWorld constant should be \"Hello World!\"', () => {
    expect(helloWorld).toBe('Hello World!');
});" > test/backend/index.test.ts

  echo "import { add } from '../../src/backend/math';

test('add function should return the sum of two numbers', () => {
    expect(add(2, 3)).toBe(5);
});" > test/backend/math.test.ts
}

