#!/bin/bash
newTsp_setup_frontend_create_scripts() {
  echo "Creating scripts..."
  cat > scripts/startExposeFrontend.sh << EOF
#!/bin/bash
npx http-server public -p 8089 -c-1
EOF
  chmod +x scripts/startExposeFrontend.sh

  jq '.scripts |= .+ {
    "start:frontend": "parcel src/frontend/index.ts --dist-dir public",
    "build:frontend": "parcel build src/frontend/index.ts --dist-dir public --no-cache",
    "build:frontend:watch": "parcel watch src/frontend/index.ts --dist-dir public",
    "serve": "http-server public -p 8080 -c-1",
    "dev:frontend": "parcel src/frontend/index.ts --dist-dir public",
    "test:frontend": "node --test --import tsx/esm",
    "test:frontend:watch": "node --watch --test --import tsx/esm",
    "typecheck:frontend": "tsc --project tsconfig.frontend.json",
    "build": "npm run build:frontend",
    "start": "npm run build:frontend && npm run serve",
    "test": "npm run test:frontend",
  }' package.json > temp.json && mv temp.json package.json
}

