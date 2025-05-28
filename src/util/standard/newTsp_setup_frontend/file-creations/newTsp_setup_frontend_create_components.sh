#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_frontend_create_components() {
  echo "Creating frontend components..."
  cat <<EOF >src/frontend/components/Counter.ts
export class Counter {
  private count = 0;
  private element: HTMLElement;

  constructor(element: HTMLElement) {
    this.element = element;
    this.render();
  }

  increment(): void {
    this.count++;
    this.render();
  }

  decrement(): void {
    this.count--;
    this.render();
  }

  private render(): void {
    this.element.textContent = this.count+"";
  }
}
EOF
}
