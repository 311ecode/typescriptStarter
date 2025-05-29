#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.
newTsp_setup_frontend_install_deps() {
  echo "Installing frontend dependencies..."
  npm install --save-dev parcel @parcel/transformer-typescript-tsc http-server @types/jquery @testing-library/dom jsdom puppeteer jsdom node-css-require concurrently serve-handler
  npm install --save jquery http-server
}
