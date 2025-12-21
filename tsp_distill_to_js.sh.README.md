# tsp_distill_to_js.sh - TypeScript to JavaScript Distillation Script

This script processes TypeScript files, extracting and converting them to JavaScript while maintaining a clean, functional code structure.

## Parameters Section

### Required Parameters
- **INPUT_DIR** (positional parameter 1): Source directory containing TypeScript files to process
- **OUTPUT_DIR** (positional parameter 2): Target directory for generated JavaScript files

### Optional Parameters
- **--help** or **-h**: Display this help message and exit
- **--verbose** or **-v**: Enable verbose output showing detailed processing information
- **--dry-run**: Perform a trial run without actually writing files
- **--exclude** <pattern>: Exclude files matching the specified pattern (can be used multiple times)
- **--include** <pattern>: Include only files matching the specified pattern (can be used multiple times)

### Environment Variables
- **TSC_PATH**: Custom path to TypeScript compiler (default: looks for `tsc` in PATH)
- **NODE_PATH**: Custom path to Node.js executable (default: looks for `node` in PATH)

## Usage Examples

### Basic Usage
```bash
./tsp_distill_to_js.sh ./src ./dist
```

### Verbose Mode with Exclusion
```bash
./tsp_distill_to_js.sh --verbose --exclude "*.test.ts" ./src ./dist
```

### Dry Run to Preview Changes
```bash
./tsp_distill_to_js.sh --dry-run --include "*.service.ts" ./src ./dist
```

### Multiple Include/Exclude Patterns
```bash
./tsp_distill_to_js.sh \
  --include "*.controller.ts" \
  --exclude "*test*" \
  --exclude "*spec*" \
  ./src ./dist
```

### Using Custom TypeScript Compiler
```bash
TSC_PATH="/usr/local/bin/tsc-4.8" ./tsp_distill_to_js.sh ./src ./dist
```

## Detailed Information

### Processing Pipeline
1. **File Discovery**: Recursively scans INPUT_DIR for `.ts` files
2. **Pattern Filtering**: Applies include/exclude patterns (if specified)
3. **TypeScript Compilation**: Uses TypeScript compiler with minimal configuration
4. **Code Cleanup**: Removes TypeScript-specific syntax while preserving functionality
5. **Output Generation**: Writes processed JavaScript files to OUTPUT_DIR

### File Structure Preservation
- Maintains original directory structure from source to destination
- Preserves relative paths between files
- Handles nested directories automatically

### Error Handling
- Validates input parameters before processing
- Checks for required dependencies (TypeScript, Node.js)
- Provides clear error messages for common issues
- Continues processing other files if one fails (non-fatal errors)

### Performance Considerations
- Processes files in parallel where possible
- Uses incremental compilation for repeated runs
- Minimal memory footprint for large codebases

### Output Characteristics
- Generated JavaScript follows ES6+ standards
- Preserves comments and documentation
- Maintains functional programming patterns
- Avoids unnecessary object-oriented constructs when possible

### Configuration Files
The script looks for (in order of priority):
1. `tsconfig.distill.json` in INPUT_DIR
2. `tsconfig.json` in INPUT_DIR
3. Uses minimal default configuration if none found

### Exit Codes
- `0`: Success
- `1`: General error
- `2`: Invalid parameters
- `3`: Missing dependencies
- `4`: Input/output directory errors

### Best Practices
1. Always run with `--dry-run` first to preview changes
2. Use version control before processing large codebases
3. Test generated JavaScript files thoroughly
4. Consider using `--verbose` for debugging complex transformations

### Limitations
- Does not handle TypeScript decorators
- May require manual adjustment for complex generic types
- Some advanced TypeScript features may need post-processing

### Related Files
- Configuration: `tsconfig.distill.json` (optional)
- Logs: Outputs to stdout/stderr, can be redirected to files
- Cache: May create temporary files in system temp directory

### Dependencies
- TypeScript 4.0+ (recommended 4.5+)
- Node.js 14+ (recommended 16+)
- Bash 4.0+ (for advanced pattern matching)

### Security Considerations
- Does not execute generated code
- Validates file paths to prevent directory traversal
- Uses safe file operations with proper permissions checking

For issues or feature requests, please check the script's inline documentation or contact the maintainer.
