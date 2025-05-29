#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_frontend_create_configs() {
  echo "Creating configuration files..."

  cat >tsconfig.json <<EOF
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

}
