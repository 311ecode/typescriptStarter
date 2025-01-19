#!/bin/bash
newTsp_init_typescript() {
  npx tsc --init --moduleResolution nodenext --module nodenext --target es2022 --outDir dest \
          --strict false 
}
