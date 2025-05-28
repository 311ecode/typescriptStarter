#!/bin/bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_frontend_create_base_files() {
  echo "Creating base frontend files..."

  cat >public/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TypeScript Frontend</title>
  <link rel="stylesheet" href="./index.css">
</head>
<body>
  <div id="app"></div>
  <script src="./index.js"></script>
</body>
</html>
EOF

  echo 'import "./styles.css";

const appElement = document.getElementById("app");

if (appElement) {
  appElement.innerHTML = `
    <div class="container">
      <h1>TypeScript Frontend</h1>
      <p>This is a simple TypeScript frontend project.</p>
      <button id="clickBtn">Click me!</button>
      <p id="clickCount">Button clicked 0 times</p>
    </div>
  `;

  const btnElement = document.getElementById("clickBtn");
  const countElement = document.getElementById("clickCount");
  let count = 0;

  if (btnElement && countElement) {
    btnElement.addEventListener("click", () => {
      count++;
      countElement.textContent = `Button clicked ${count} times`;
    });
  }
}

export const appName = "TypeScript Frontend";
' >src/frontend/index.ts

  echo '/* Main styles */
body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  margin: 0;
  padding: 0;
  background-color: #f5f5f5;
}

.container {
  max-width: 800px;
  margin: 2rem auto;
  padding: 2rem;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

h1 {
  color: #333;
}

button {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 4px;
}

button:hover {
  background-color: #45a049;
}
' >src/frontend/styles.css
}
