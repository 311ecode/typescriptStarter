#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_node_create_files() {
  echo "Creating backend source files..."

  echo 'export const helloWorld = "Hello World!";

console.log("Hello World!");
' >src/backend/index.ts

  echo 'export function add(a: number, b: number): number {
  return a + b;
}' >src/backend/math.ts
}
