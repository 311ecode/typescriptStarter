#!/bin/bash
newTsp_init_git() {
  git init
  touch README.md
  touch .gitignore
  echo "node_modules" > .gitignore
  echo "dist" >> .gitignore
}

