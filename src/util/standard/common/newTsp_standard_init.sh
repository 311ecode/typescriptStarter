#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

newTsp_standard_init() {
  local folder_name="$1"

  mkdir "$folder_name"
  cd "$folder_name" || exit

  newTsp_setup_common "$folder_name"

  echo "
  Project initialized successfully at:
  "
  pwd
  cd ..
}
