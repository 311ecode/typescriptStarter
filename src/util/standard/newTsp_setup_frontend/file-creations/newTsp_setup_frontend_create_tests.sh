#!/bin/bash
newTsp_setup_frontend_create_tests() {
  echo "Creating test files..."

  # Ensure the test directories exist first
  mkdir -p test/frontend
  mkdir -p test/e2e

  cat <<EOF >test/frontend/Counter.test.js
import { register } from 'node-css-require';
register();

import { test } from "node:test";
import assert from "node:assert";
import { JSDOM } from "jsdom";
import { Counter } from "../../src/frontend/components/Counter.js";

// Set up global document and window before tests
const dom = new JSDOM('<!DOCTYPE html><html><body><div id="counter"></div></body></html>');
global.document = dom.window.document;
global.window = dom.window;

test("Counter", async (t) => {
  let counter;
  let element;

  t.beforeEach(() => {
    // Reset the document body for each test
    document.body.innerHTML = '<div id="counter"></div>';
    element = document.getElementById("counter");
    counter = new Counter(element);
  });

  await t.test("should initialize with count of 0", () => {
    assert.strictEqual(element.textContent, "0"); // Modified line
  });

  await t.test("should increment counter", () => {
    counter.increment();
    assert.strictEqual(element.textContent, "1"); // Modified line
  });

  await t.test("should decrement counter", () => {
    counter.increment();
    counter.decrement();
    assert.strictEqual(element.textContent, "0"); // Modified line
  });
});
EOF

  cat <<EOF >test/e2e/setup.js
import puppeteer from 'puppeteer';
import handler from 'serve-handler';
import http from 'http';
import { exec } from 'child_process';
import { promisify } from 'util';

const execPromise = promisify(exec);
let server;
let browser;

export default async function setup() {
  console.log("Building frontend...");
  
  try {
    // First build the frontend
    const { stdout, stderr } = await execPromise('npm run build:frontend');
    console.log("Build stdout:", stdout);
    if (stderr) console.error("Build stderr:", stderr);
    
    console.log("Frontend build completed successfully");
    
    // Create HTTP server using serve-handler
    console.log("Starting HTTP server...");
    server = http.createServer((request, response) => {
      // Serve files from the public directory
      return handler(request, response, {
        public: 'public',
        cleanUrls: true
      });
    });
    
    // Start the server on port 8089
    await new Promise(resolve => {
      server.listen(8089, () => {
        console.log('Server running at http://localhost:8089');
        resolve();
      });
    });
    
    // Launch browser
    console.log("Launching browser...");
    browser = await puppeteer.launch({
      headless: "new",
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    
    // Open a new page
    const page = await browser.newPage();
    
    // Set viewport size
    await page.setViewport({ width: 1280, height: 800 });
    
    // Enable console logging from the browser
    page.on('console', (msg) => console.log('Browser console:', msg.text()));
    
    // Set global variables for the tests
    global.browser = browser;
    global.page = page;
    
    return { browser, page };
  } catch (error) {
    console.error("Error during setup:", error);
    // Cleanup if there was an error
    if (browser) await browser.close();
    if (server && server.listening) server.close();
    throw error;
  }
}

export async function teardown() {
  console.log("Tearing down test environment...");
  
  if (browser) {
    await browser.close();
    console.log("Browser closed");
  }
  
  if (server) {
    await new Promise(resolve => {
      server.close(() => {
        console.log("HTTP server closed");
        resolve();
      });
    });
  }
}
EOF

  cat <<EOF >test/e2e/app.e2e.test.js
import { test } from "node:test";
import assert from "node:assert";
import setup, { teardown } from "./setup.js";

test("Frontend App E2E", async (t) => {
    t.before(async () => {
        console.log("Setting up test environment...");
        await setup();
        
        console.log("Navigating to application...");
        await global.page.goto("http://localhost:8089", { 
            waitUntil: 'networkidle0',
            timeout: 30000 
        });
        
        console.log("Page loaded, starting tests...");
    });

    t.after(async () => {
        console.log("Tests completed, tearing down...");
        await teardown();
    });

    await t.test("should display the initial page", async () => {
        // Wait for app div to be populated
        await global.page.waitForFunction(
            'document.getElementById("app") && document.getElementById("app").innerHTML.trim() !== ""',
            { timeout: 5000 }
        );
        
        // Now check the h1 element
        const title = await global.page.\$eval("h1", (el) => el.textContent);
        console.log("H1 content: " + title);
        
        assert.strictEqual(title, "TypeScript Frontend");
    });

    await t.test("should increment count on button click", async () => {
        console.log("Looking for click counter element...");
        await global.page.waitForSelector('#clickCount', { timeout: 5000 });
        
        const initialCount = await global.page.\$eval("#clickCount", (el) => el.textContent);
        console.log("Initial count: " +initialCount);
        assert.strictEqual(initialCount, "Button clicked 0 times");

        console.log("Looking for button...");
        await global.page.waitForSelector('#clickBtn', { timeout: 5000 });
        
        console.log("Clicking button...");
        await global.page.click("#clickBtn");
        
        console.log("Waiting after click...");
       
        await new Promise(resolve => setTimeout(resolve, 500));

        const newCount = await global.page.\$eval("#clickCount", (el) => el.textContent);
        console.log("New count: " + newCount);
        assert.strictEqual(newCount, "Button clicked 1 times");
    });
});
EOF

  # Verify files were created
  if [ -f "test/frontend/Counter.test.js" ] && [ -f "test/e2e/app.e2e.test.js" ]; then
    echo "  ✅ Test files created successfully."
  else
    echo "  ❌ Failed to create test files."
  fi
}
