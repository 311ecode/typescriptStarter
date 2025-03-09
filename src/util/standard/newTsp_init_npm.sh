newTsp_init_npm() {
  npm init -y

  # Add the lines to package.json
  jq '. + {
    "main": "dist/index.cjs",
    "module": "dist/index.js",
    "types": "dist/index.d.ts",
    "exports": {
      ".": {
        "require": "./dist/index.cjs",
        "import": "./dist/index.js",
        "types": "./dist/index.d.ts"
      }
    },
    "type": "module",
    "files": [
      "dist/**"
    ]
  }' package.json > temp.json && mv temp.json package.json

  # Set the scripts in package.json with updated test commands
  jq '.scripts = {
    "tsart": "npx ts-node src/index.ts",
    "start": "node dist/index.js",
    "test": "npm run test:node",
    "test:node": "npx jest --config jest.config.node.js --coverage",
    "test:ci": "npx jest --ci --config jest.config.node.js --coverage",
    "build": "tsup src/index.ts --format esm,cjs --dts --clean --sourcemap",
    "build:watch": "tsup src/index.ts --format esm,cjs --dts --clean --sourcemap --watch",
    "dev": "tsup src/index.ts --format esm,cjs --watch",
    "lint": "ts-standard",
    "lint:fix": "ts-standard --fix",
    "format": "prettier --write src/**/*.ts",
    "typecheck": "tsc --project tsconfig.node.json",
    "watch": "tsc --project tsconfig.node.json --watch"
  }' package.json > temp.json && mv temp.json package.json
}
