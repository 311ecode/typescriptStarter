#!/bin/bash

newTsp_setup_node_create_tests() {
  echo "Creating backend test files..."

  # Ensure test directories exist
  mkdir -p test/backend

  # Create basic test file for backend index
  cat >test/backend/index.test.ts <<EOF
import { test } from 'node:test';
import assert from 'node:assert';
import { helloWorld } from '../../src/backend/index.js';

test('Backend Index Tests', async (t) => {
  await t.test('helloWorld constant should be "Hello World!"', () => {
    assert.strictEqual(helloWorld, 'Hello World!');
  });
});
EOF

  # Create basic test file for math module
  cat >test/backend/math.test.ts <<EOF
import { test } from 'node:test';
import assert from 'node:assert';
import { add } from '../../src/backend/math.js';

test('Math Module Tests', async (t) => {
  await t.test('add function should return the sum of two numbers', () => {
    assert.strictEqual(add(2, 3), 5);
  });
});
EOF

  echo "Backend test files created successfully."
}
