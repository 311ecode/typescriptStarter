#!/bin/bash
newTsp_init_typescript() {
  npx tsc --init --moduleResolution bundler --module ES2015 --target es2022 --outDir dest \
          --strict false --declaration 
}
