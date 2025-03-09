#!/bin/bash
newTsp_setup_frontend_create_tests() {
  echo "Creating test files..."
  
  echo 'import { Counter } from "../../src/frontend/components/Counter";

describe("Counter", () => {
  let counter: Counter;
  let element: HTMLElement;

  beforeEach(() => {
    document.body.innerHTML = "<div id=\"counter\"></div>";
    element = document.getElementById("counter") as HTMLElement;
    counter = new Counter(element);
  });

  test("should initialize with count of 0", () => {
    expect(element.textContent).toBe("Count: 0");
  });

  test("should increment counter", () => {
    counter.increment();
    expect(element.textContent).toBe("Count: 1");
  });

  test("should decrement counter", () => {
    counter.increment();
    counter.decrement();
    expect(element.textContent).toBe("Count: 0");
  });
});
' > test/frontend/Counter.test.ts

  echo 'import { setup: setupPuppeteer } from "jest-environment-puppeteer";

export default async () => {
  await setupPuppeteer();
};
' > test/e2e/setup.ts

  echo 'describe("Frontend App E2E", () => {
  beforeAll(async () => {
    await page.goto("http://localhost:8080");
  });

  it("should display the initial page", async () => {
    const title = await page.$eval("h1", (el) => el.textContent);
    expect(title).toBe("TypeScript Frontend");
  });

  it("should increment count on button click", async () => {
    const initialCount = await page.$eval("#clickCount", (el) => el.textContent);
    expect(initialCount).toBe("Button clicked 0 times");

    await page.click("#clickBtn");
    await page.waitForTimeout(100);

    const newCount = await page.$eval("#clickCount", (el) => el.textContent);
    expect(newCount).toBe("Button clicked 1 times");
  });
});
' > test/e2e/app.e2e.test.ts
}

