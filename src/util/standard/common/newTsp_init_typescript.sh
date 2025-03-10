#!/bin/bash
newTsp_init_typescript() {
  echo "Initializing TypeScript configuration..."
  
  # Create tsconfig.node.json directly without using tsc --init which can fail
  cat > tsconfig.node.json << EOF
{
  "compilerOptions": {
    "target": "es2022",
    "module": "ES2015",
    "moduleResolution": "bundler",
    "outDir": "dist",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": false,
    "skipLibCheck": true,
    "declaration": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOF
  
  # Create base tsconfig.json that extends node config
  cat > tsconfig.json << EOF
{
  "extends": "./tsconfig.node.json",
  "compilerOptions": {
    "outDir": "dist"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOF

  # Verify config files were created
  if [ -f "tsconfig.node.json" ] && [ -f "tsconfig.json" ]; then
    echo "  ✅ TypeScript configuration created successfully."
  else
    echo "  ❌ Failed to create TypeScript configuration files."
  fi
}