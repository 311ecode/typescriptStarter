#!/bin/bash
newTsp_setup_node_create_files() {
  echo "Creating backend source files..."
  
  echo 'export const helloWorld = "Hello World!";

console.log("Hello World!");
' > src/backend/index.ts

  echo 'export function add(a: number, b: number): number {
  return a + b;
}' > src/backend/math.ts
}

