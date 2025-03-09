#!/bin/bash
newTsp_setup_frontend_create_components() {
  echo "Creating frontend components..."
  echo 'export class Counter {
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
    this.element.textContent = `Count: ${this.count}`;
  }
}
' > src/frontend/components/Counter.ts
}

