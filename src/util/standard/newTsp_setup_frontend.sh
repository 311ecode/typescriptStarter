#!/bin/bash
newTsp_setup_frontend() {
  echo "Setting up frontend..."
  
  # Install frontend-specific dependencies
  npm install --save-dev parcel @parcel/transformer-typescript-tsc http-server \
                       @types/jquery @testing-library/dom jsdom
  
  # Configure TypeScript for frontend
  cat > tsconfig.frontend.json << EOF
{
  "compilerOptions": {
    "target": "ESNext",
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": false,
    "skipLibCheck": true,
    "outDir": "public",
    "rootDir": "src",
    "sourceMap": true,
    "allowSyntheticDefaultImports": true,
    "baseUrl": ".",
    "jsx": "preserve"
  },
  "include": ["src/frontend/**/*"],
  "exclude": ["node_modules", "dist", "public"]
}
EOF

  # Create E2E test configuration
  cat > tsconfig.server.json << EOF
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": false,
    "skipLibCheck": true,
    "outDir": "dist",
    "sourceMap": true
  },
  "include": ["test/e2e/**/*"],
  "exclude": ["node_modules", "public"]
}
EOF

  # Create Jest configuration for frontend
  cat << EOF > jest.config.frontend.js
// jest.config.frontend.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'jsdom',
  extensionsToTreatAsEsm: ['.ts', '.tsx'],
  moduleFileExtensions: ['tsx', 'ts', 'js', 'json', 'node'],
  modulePaths: ['../../node_modules/'],
  moduleDirectories: ['node_modules', '../../node_modules'],
  testMatch: [
    '**/test/frontend/**/*.ts?(x)',
    '**/test/frontend/?(*.)+(spec|test).ts?(x)'
  ],
  verbose: true,
};
EOF

  # Create E2E test configuration
  cat << EOF > jest.e2e.config.js
// jest.e2e.config.js
/** @type {import('ts-jest').JestConfigWithTsJest} */
export default {
  preset: 'ts-jest/presets/default-esm',
  testEnvironment: 'node',
  extensionsToTreatAsEsm: ['.ts', '.tsx'],
  moduleFileExtensions: ['tsx', 'ts', 'js', 'json', 'node'],
  modulePaths: ['../../node_modules/'],
  moduleDirectories: ['node_modules', '../../node_modules'],
  testMatch: [
    '**/test/e2e/**/*.e2e.test.ts',
  ],
  verbose: true,
  transform: {
    '^.+\\.ts(x?)$': [
      'ts-jest',
      {
        useESM: true,
        tsconfig: '<rootDir>/tsconfig.server.json',
      },
    ],
  },
};
EOF

  # Create basic Jest config if it doesn't exist
  if [ ! -f "jest.config.js" ]; then
    cat << EOF > jest.config.js
// jest.config.js
import frontendConfig from './jest.config.frontend.js';

export default {
  ...frontendConfig,
  // Add any overrides for the base config here
};
EOF
  else
    # Update the Jest config to include the frontend config
    cat << EOF > jest.config.js.new
// jest.config.js
import frontendConfig from './jest.config.frontend.js';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);

// Import existing config if it exists
let existingConfig = {};
try {
  existingConfig = require('./jest.config.js');
} catch (e) {
  // No existing config, that's OK
}

export default {
  ...frontendConfig,
  ...existingConfig,
  // Ensure we can run both frontend and backend tests if needed
  projects: [
    ...(existingConfig.projects || []),
    '<rootDir>/jest.config.frontend.js',
  ],
};
EOF
    mv jest.config.js.new jest.config.js
  fi
  
  # Create frontend directory structure
  mkdir -p src/frontend src/frontend/components public
  
  # Create index.html in public
  cat > public/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TypeScript Frontend</title>
</head>
<body>
  <div id="app"></div>
  <script src="./index.js"></script>
</body>
</html>
EOF

  # Create main frontend index.ts file
  touch src/frontend/index.ts
  echo 'import "./styles.css";

// DOM Element references
const appElement = document.getElementById("app");

// Initialize app
if (appElement) {
  appElement.innerHTML = `
    <div class="container">
      <h1>TypeScript Frontend</h1>
      <p>This is a simple TypeScript frontend project.</p>
      <button id="clickBtn">Click me!</button>
      <p id="clickCount">Button clicked 0 times</p>
    </div>
  `;

  // Add event listener
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

// Export something to make this a module
export const appName = "TypeScript Frontend";
' > src/frontend/index.ts

  # Create a simple CSS file
  touch src/frontend/styles.css
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
' > src/frontend/styles.css

  # Create a simple component
  touch src/frontend/components/Counter.ts
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

  # Create tests for frontend
  mkdir -p test/frontend test/e2e
  
  # Create a frontend test
  touch test/frontend/Counter.test.ts
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

  # Create a basic e2e test
  touch test/e2e/app.e2e.test.ts
  echo 'describe("Frontend App", () => {
  it("should be testable with e2e tests", () => {
    expect(true).toBe(true);
  });
});
' > test/e2e/app.e2e.test.ts

  # Create scripts directory if it doesn't exist
  mkdir -p scripts
  
  # Create a script to expose the frontend using http-server
  cat > scripts/startExposeFrontend.sh << EOF
#!/bin/bash
npx http-server public -p 8080 -c-1
EOF
  chmod +x scripts/startExposeFrontend.sh

  # Add frontend specific scripts to package.json
  jq '.scripts += {
    "start:frontend": "parcel src/frontend/index.ts --dist-dir public",
    "build:frontend": "parcel build src/frontend/index.ts --dist-dir public --no-cache",
    "build:frontend:watch": "parcel watch src/frontend/index.ts --dist-dir public",
    "serve": "http-server public -p 8080 -c-1",
    "dev:frontend": "parcel src/frontend/index.ts --dist-dir public",
    "test:frontend": "jest --config jest.config.frontend.js",
    "test:e2e": "jest --config jest.e2e.config.js",
    "typecheck:frontend": "tsc --project tsconfig.frontend.json"
  }' package.json > temp.json && mv temp.json package.json
  
  # Add combined test script if it doesn't exist
  if ! jq -e '.scripts.test' package.json > /dev/null 2>&1; then
    jq '.scripts += {
      "test": "npm run test:frontend"
    }' package.json > temp.json && mv temp.json package.json
  else
    # Update test script to include frontend tests
    existing_test=$(jq -r '.scripts.test' package.json)
    if [[ "$existing_test" != *"test:frontend"* ]]; then
      jq --arg test "$existing_test && npm run test:frontend" '.scripts.test = $test' package.json > temp.json && mv temp.json package.json
    fi
  fi
  
  # Add combined build script if it doesn't exist
  if ! jq -e '.scripts.build' package.json > /dev/null 2>&1; then
    jq '.scripts += {
      "build": "npm run build:frontend"
    }' package.json > temp.json && mv temp.json package.json
  else
    # Update build script to include frontend build
    existing_build=$(jq -r '.scripts.build' package.json)
    if [[ "$existing_build" != *"build:frontend"* ]]; then
      jq --arg build "$existing_build && npm run build:frontend" '.scripts.build = $build' package.json > temp.json && mv temp.json package.json
    fi
  fi
  
  # Add start script if it doesn't exist
  if ! jq -e '.scripts.start' package.json > /dev/null 2>&1; then
    jq '.scripts += {
      "start": "npm run build:frontend && npm run serve"
    }' package.json > temp.json && mv temp.json package.json
  fi
  
  echo "Frontend setup completed."
}