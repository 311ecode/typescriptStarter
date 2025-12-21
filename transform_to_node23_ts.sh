#!/bin/bash

transform_to_node23_ts() {
    local target_dir="$1"
    
    if [ ! -d "$target_dir" ] || [ ! -f "$target_dir/package.json" ]; then
        echo "❌ Error: $target_dir is not a valid node project (no package.json found)."
        return 1
    fi

    echo "🚀 Transforming: $target_dir"
    cd "$target_dir" || return 1

    # 1. Rename ALL .js files recursively to .ts
    echo "📁 Renaming .js files to .ts..."
    find . -name "*.js" -type f | while read -r file; do
        if [[ "$file" != *"/node_modules/"* ]] && [[ "$file" != "./node_modules/"* ]]; then
            new_name="${file%.js}.ts"
            echo "  Renaming: $file -> $new_name"
            mv "$file" "$new_name" 2>/dev/null
        fi
    done

    # 2. Update package.json
    echo "📝 Updating package.json..."
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
        
        pkg.type = 'module';
        if (pkg.main) pkg.main = pkg.main.replace(/\.js$/, '.ts');

        // Setup scripts for Node 23 native TS
        pkg.scripts = {
            ...pkg.scripts,
            'test': 'bash -c \"find test -name \\\"*.test.ts\\\" -type f -print0 | xargs -0 node --experimental-transform-types --test\"',
            'start': 'node --experimental-transform-types ' + (pkg.main || 'index.ts'),
            'dev': 'node --watch --experimental-transform-types ' + (pkg.main || 'index.ts')
        };

        // Keep Typescript for the LSP/Editor, but remove runners like ts-node
        pkg.devDependencies = pkg.devDependencies || {};
        const toRemove = ['tsx', 'ts-node', 'ts-jest'];
        toRemove.forEach(dep => delete pkg.devDependencies[dep]);
        
        pkg.devDependencies['@types/node'] = '^22.10.2';
        pkg.devDependencies['typescript'] = '^5.7.0';

        fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
    "

    # 3. Regex replacements for ESM & TS Extensions
    echo "🔧 Fixing imports and converting to ESM..."
    find . -name "*.ts" -type f | grep -v node_modules | while read -r file; do
        # A) Convert require to import
        sed -i -E "s/(const|let|var)[[:space:]]+([[:alnum:]_]+)[[:space:]]*=[[:space:]]*require\(['\"]([^'\"]+)['\"]\)/import \2 from '\3'/g" "$file"
        
        # B) Add .ts extension to relative imports (Node 23 ESM requirement)
        # Matches: from './something' or from '../something' but NOT from 'lodash'
        sed -i -E "s/from[[:space:]]+['\"](\.\.?\/[^'\"]+)(['\"])/from '\1.ts\2/g" "$file"
        
        # C) Cleanup double extensions if they existed (e.g., .ts.ts)
        sed -i -E "s/\.ts\.ts/\.ts/g" "$file"

        # D) Convert module.exports
        sed -i -E "s/module\.exports[[:space:]]*=[[:space:]]*/export default /g" "$file"
        sed -i -E "s/exports\.([[:alnum:]_]+)[[:space:]]*=[[:space:]]*/export const \1 = /g" "$file"
    done

    # 4. Create the 'Node 23 Compatible' tsconfig.json
    echo "📄 Creating Node 23 specific tsconfig.json..."
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "allowImportingTsExtensions": true,
    "noEmit": true,
    "strict": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "isolatedModules": true
  },
  "include": ["src/**/*", "test/**/*", "example.ts"]
}
EOF

    echo "✅ Done! Run 'npm install' then 'npm test'."
    cd - > /dev/null
}


#!/bin/bash

transform_to_node23_ts() {
    local target_dir="$1"
    
    if [ ! -d "$target_dir" ] || [ ! -f "$target_dir/package.json" ]; then
        echo "❌ Error: $target_dir is not a valid node project (no package.json found)."
        return 1
    fi

    echo "🚀 Transforming: $target_dir"
    cd "$target_dir" || return 1

    # 1. Rename ALL .js files recursively to .ts
    echo "📁 Renaming .js files to .ts..."
    find . -name "*.js" -type f | while read -r file; do
        if [[ "$file" != *"/node_modules/"* ]] && [[ "$file" != "./node_modules/"* ]]; then
            new_name="${file%.js}.ts"
            echo "  Renaming: $file -> $new_name"
            mv "$file" "$new_name" 2>/dev/null
        fi
    done

    # 2. Update package.json
    echo "📝 Updating package.json..."
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
        
        pkg.type = 'module';
        if (pkg.main) pkg.main = pkg.main.replace(/\.js$/, '.ts');

        // Setup scripts for Node 23 native TS
        pkg.scripts = {
            ...pkg.scripts,
            'test': 'bash -c \"find test -name \\\"*.test.ts\\\" -type f -print0 | xargs -0 node --experimental-transform-types --test\"',
            'start': 'node --experimental-transform-types ' + (pkg.main || 'index.ts'),
            'dev': 'node --watch --experimental-transform-types ' + (pkg.main || 'index.ts')
        };

        // Keep Typescript for the LSP/Editor, but remove runners like ts-node
        pkg.devDependencies = pkg.devDependencies || {};
        const toRemove = ['tsx', 'ts-node', 'ts-jest'];
        toRemove.forEach(dep => delete pkg.devDependencies[dep]);
        
        pkg.devDependencies['@types/node'] = '^22.10.2';
        pkg.devDependencies['typescript'] = '^5.7.0';

        fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
    "

    # 3. Regex replacements for ESM & TS Extensions
    echo "🔧 Fixing imports and converting to ESM..."
    find . -name "*.ts" -type f | grep -v node_modules | while read -r file; do
        # A) Convert require to import
        sed -i -E "s/(const|let|var)[[:space:]]+([[:alnum:]_]+)[[:space:]]*=[[:space:]]*require\(['\"]([^'\"]+)['\"]\)/import \2 from '\3'/g" "$file"
        
        # B) Add .ts extension to relative imports (Node 23 ESM requirement)
        # Matches: from './something' or from '../something' but NOT from 'lodash'
        sed -i -E "s/from[[:space:]]+['\"](\.\.?\/[^'\"]+)(['\"])/from '\1.ts\2/g" "$file"
        
        # C) Cleanup double extensions if they existed (e.g., .ts.ts)
        sed -i -E "s/\.ts\.ts/\.ts/g" "$file"

        # D) Convert module.exports
        sed -i -E "s/module\.exports[[:space:]]*=[[:space:]]*/export default /g" "$file"
        sed -i -E "s/exports\.([[:alnum:]_]+)[[:space:]]*=[[:space:]]*/export const \1 = /g" "$file"
    done

    # 4. Create the 'Node 23 Compatible' tsconfig.json
    echo "📄 Creating Node 23 specific tsconfig.json..."
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "allowImportingTsExtensions": true,
    "noEmit": true,
    "strict": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "isolatedModules": true
  },
  "include": ["src/**/*", "test/**/*", "example.ts"]
}
EOF

    echo "✅ Done! Run 'npm install' then 'npm test'."
    cd - > /dev/null
}

#!/bin/bash

transform_to_node23_ts() {
    local target_dir="$1"
    
    if [ ! -d "$target_dir" ] || [ ! -f "$target_dir/package.json" ]; then
        echo "❌ Error: $target_dir is not a valid node project (no package.json found)."
        return 1
    fi

    echo "🚀 Transforming: $target_dir"
    cd "$target_dir" || return 1

    # 1. Rename ALL .js files recursively to .ts
    echo "📁 Renaming .js files to .ts..."
    find . -name "*.js" -type f | while read -r file; do
        if [[ "$file" != *"/node_modules/"* ]] && [[ "$file" != "./node_modules/"* ]]; then
            new_name="${file%.js}.ts"
            echo "  Renaming: $file -> $new_name"
            mv "$file" "$new_name" 2>/dev/null
        fi
    done

    # 2. Update package.json
    echo "📝 Updating package.json..."
    node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
        
        pkg.type = 'module';
        if (pkg.main) pkg.main = pkg.main.replace(/\.js$/, '.ts');

        // Setup scripts for Node 23 native TS
        pkg.scripts = {
            ...pkg.scripts,
            'test': 'bash -c \"find test -name \\\"*.test.ts\\\" -type f -print0 | xargs -0 node --experimental-transform-types --test\"',
            'start': 'node --experimental-transform-types ' + (pkg.main || 'index.ts'),
            'dev': 'node --watch --experimental-transform-types ' + (pkg.main || 'index.ts')
        };

        // Keep Typescript for the LSP/Editor, but remove runners like ts-node
        pkg.devDependencies = pkg.devDependencies || {};
        const toRemove = ['tsx', 'ts-node', 'ts-jest'];
        toRemove.forEach(dep => delete pkg.devDependencies[dep]);
        
        pkg.devDependencies['@types/node'] = '^22.10.2';
        pkg.devDependencies['typescript'] = '^5.7.0';

        fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
    "

    # 3. Regex replacements for ESM & TS Extensions
    echo "🔧 Fixing imports and converting to ESM..."
    find . -name "*.ts" -type f | grep -v node_modules | while read -r file; do
        # A) Convert require to import
        sed -i -E "s/(const|let|var)[[:space:]]+([[:alnum:]_]+)[[:space:]]*=[[:space:]]*require\(['\"]([^'\"]+)['\"]\)/import \2 from '\3'/g" "$file"

        # B) Convert .js to .ts in all import/export paths FIRST
        sed -i -E "s/\.js(['\"])/\.ts\1/g" "$file"

        # C) Add .ts extension to relative imports that lack any extension
        sed -i -E "s/(from[[:space:]]+['\"])(\.\.?\/[^'\"]+)(['\"])/\1\2.ts\3/g" "$file"
        sed -i -E "s/(import[[:space:]]+['\"])(\.\.?\/[^'\"]+)(['\"])/\1\2.ts\3/g" "$file"

        # D) Cleanup double/wrong extensions
        sed -i -E "s/\.ts\.ts/\.ts/g" "$file"
        sed -i -E "s/\.js\.ts/\.ts/g" "$file"
        sed -i -E "s/\.json\.ts/\.json/g" "$file"
        sed -i -E "s/\.mjs\.ts/\.mjs/g" "$file"
        sed -i -E "s/\.cjs\.ts/\.cjs/g" "$file"

        # E) Convert module.exports to export default
        sed -i -E "s/module\.exports[[:space:]]*=[[:space:]]*/export default /g" "$file"

        # F) Convert exports.X to export const X
        sed -i -E "s/exports\.([[:alnum:]_]+)[[:space:]]*=[[:space:]]*/export const \1 = /g" "$file"
    done

    # 4. Create the 'Node 23 Compatible' tsconfig.json
    echo "📄 Creating Node 23 specific tsconfig.json..."
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "allowImportingTsExtensions": true,
    "noEmit": true,
    "strict": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "isolatedModules": true
  },
  "include": ["src/**/*", "test/**/*", "*.ts"]
}
EOF

    echo "✅ Done! Run 'npm install' then 'npm test'."
    cd - > /dev/null
}
