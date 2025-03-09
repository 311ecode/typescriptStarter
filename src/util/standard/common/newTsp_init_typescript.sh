newTsp_init_typescript() {
  npx tsc --init --moduleResolution bundler --module ES2015 --target es2022 --outDir dest \
          --strict false --declaration 
  
  # Rename the generated tsconfig.json to tsconfig.node.json
  mv tsconfig.json tsconfig.node.json
  
  # Create a base tsconfig.json that extends the node config
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
}