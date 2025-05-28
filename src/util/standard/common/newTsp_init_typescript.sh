#!/bin/bash
newTsp_init_typescript() {
  echo "Creating TypeScript configuration files..."

  # # Create tsconfig.node.json as the standalone base config (without circular reference)
  #   cat > tsconfig.node.json << EOF
  # {
  #   "compilerOptions": {
  #     "target": "es2022",
  #     "module": "ESNext",
  #     "moduleResolution": "bundler",
  #     "outDir": "dist",
  #     "esModuleInterop": true,
  #     "forceConsistentCasingInFileNames": true,
  #     "strict": false,
  #     "skipLibCheck": true,
  #     "declaration": true
  #   },
  #   "include": ["src/backend/**/*"],
  #   "exclude": ["node_modules", "dist", "**/*.test.ts"]
  # }
  # EOF

  # Create the main tsconfig.json (independent, not extending node config)
  cat >tsconfig.json <<EOF
{
  "compilerOptions": {
    "target": "es2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "outDir": "dist",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": false,
    "skipLibCheck": true,
    "declaration": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist" ,"public"]
}
EOF

  echo "TypeScript configuration files created successfully."
}
