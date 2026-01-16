# transform_to_node23_ts - Node.js 23 TypeScript Migration Tool

## Overview
`transform_to_node23_ts` is a Bash function that migrates existing JavaScript projects to use Node.js 23's native TypeScript support. It automates the conversion from CommonJS/JavaScript to ESM/TypeScript with Node 23's experimental TypeScript features.

## Prerequisites
- Node.js 23 or higher (with `--experimental-transform-types` flag support)
- Existing JavaScript project with `package.json`
- Bash shell environment

## Usage

### Basic Usage
```bash
# Navigate to your project directory
cd /path/to/your-js-project

# Run the transformation
transform_to_node23_ts .
```

### Alternative Usage
```bash
# Transform a specific directory
transform_to_node23_ts /path/to/your-project
```

## What It Does

### 1. File Conversion
- Renames all `.js` files to `.ts` recursively
- Skips `node_modules` directory
- Preserves directory structure

### 2. Package.json Updates
- Sets `"type": "module"` for ESM support
- Updates `main` entry point from `.js` to `.ts`
- Adds Node 23 specific scripts:
  - `test`: Runs TypeScript tests with native Node 23 support
  - `start`: Runs the main TypeScript file
  - `dev`: Watches and runs with hot reload
- Updates devDependencies:
  - Adds/updates `typescript` and `@types/node`
  - Removes TypeScript runners (`ts-node`, `tsx`, `ts-jest`)

### 3. Code Transformation
- Converts `require()` statements to `import` statements
- Adds `.ts` extensions to relative imports
- Converts `module.exports` to `export default`
- Converts `exports.property` to `export const property`
- Cleans up import/export extensions

### 4. TypeScript Configuration
Creates a `tsconfig.json` optimized for Node 23 with:
- `"allowImportingTsExtensions": true`
- `"noEmit": true` (Node 23 handles TypeScript directly)
- `"module": "NodeNext"` and `"moduleResolution": "NodeNext"`

## Scripts Added to package.json

| Script | Purpose |
|--------|---------|
| `npm test` | Runs all `.test.ts` files using Node 23's native test runner |
| `npm start` | Runs the main TypeScript file with native TypeScript support |
| `npm run dev` | Watches and runs with hot reload |

## Example Migration

**Before:**
```javascript
// index.js
const express = require('express');
const config = require('./config');

module.exports = {
  startServer
};

function startServer() {
  const app = express();
  app.listen(3000);
}
```

**After:**
```typescript
// index.ts
import express from 'express';
import config from './config.ts';

export default {
  startServer
};

function startServer() {
  const app = express();
  app.listen(3000);
}
```

## Post-Migration Steps

1. **Install updated dependencies:**
   ```bash
   npm install
   ```

2. **Run tests to verify migration:**
   ```bash
   npm test
   ```

3. **Start the application:**
   ```bash
   npm start
   ```

## Node.js 23 Flags Used

The migration configures your project to use:
- `--experimental-transform-types`: Enables native TypeScript compilation
- `--watch`: For development hot reload
- Native Node test runner for `.test.ts` files

## Limitations

1. **Node.js 23 Required**: The transformed project requires Node.js 23+
2. **Experimental Features**: Uses experimental TypeScript features
3. **Complex Projects**: May require manual adjustments for:
   - Third-party module imports
   - Dynamic imports
   - Special file extensions (.mjs, .cjs, .json)
4. **Build Process**: Since Node 23 compiles TypeScript on the fly, there's no separate build step

## Common Issues & Solutions

### Issue: "Cannot find module"
**Solution**: Check import paths have correct `.ts` extensions

### Issue: Type errors after conversion
**Solution**: Run `npx tsc --noEmit` to see TypeScript errors

### Issue: Missing dependencies
**Solution**: Run `npm install` after migration

## Related Tools

- `newTsp`: Creates new TypeScript projects from scratch
- `transform_to_node23_ts`: Migrates existing JavaScript projects

## Notes

- This tool is **destructive** - backup your project before running
- Some manual adjustments may be needed for complex projects
- The migration focuses on compatibility with Node 23's native TypeScript features
- Consider this a starting point for migration, not a complete solution

## See Also

- [Node.js 23 Release Notes](https://nodejs.org/en/blog/release/v23.0.0/)
- [TypeScript with Node.js](https://www.typescriptlang.org/docs/handbook/typescript-in-5-minutes.html)
- [ES Modules in Node.js](https://nodejs.org/api/esm.html)
