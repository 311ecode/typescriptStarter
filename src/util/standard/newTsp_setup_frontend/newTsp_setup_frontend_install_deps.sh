#!/bin/bash
newTsp_setup_frontend_install_deps() {
  echo "Installing frontend dependencies..."
  npm install --save-dev parcel @parcel/transformer-typescript-tsc http-server @types/jquery @testing-library/dom jsdom puppeteer jsdom node-css-require concurrently serve-handler;
  npm install --save jquery http-server;
}

