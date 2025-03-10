#!/bin/bash

newTsp_setup_node_create_tests() {
  echo "Creating backend test files..."
  
  # Ensure test directories exist
  mkdir -p test/backend
  
  # Create basic test file for backend index
  cat > test/backend/index.test.ts << EOF
import { helloWorld } from '../../src/backend/index';

describe('Backend Index Tests', () => {
  test('helloWorld constant should be "Hello World!"', () => {
    expect(helloWorld).toBe('Hello World!');
  });
});
EOF

  # Create basic test file for math module
  cat > test/backend/math.test.ts << EOF
import { add } from '../../src/backend/math';

describe('Math Module Tests', () => {
  test('add function should return the sum of two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });
});
EOF

  echo "Backend test files created successfully."
}