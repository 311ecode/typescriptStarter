#!/usr/bin/env bash
# Copyright © 2025 Imre Toth <tothimre@gmail.com> - Proprietary Software. See LICENSE file for terms.

newTsp_setup_node() {
  echo "Setting up Node.js backend..."
  # Skip common dependency installation since it's already done
  newTsp_setup_node_install_deps # Node-specific dependencies only
  newTsp_setup_node_create_configs
  newTsp_setup_node_create_structure
  newTsp_setup_node_create_files
  newTsp_setup_node_create_tests
  newTsp_setup_node_update_package
  newTsp_setup_node_create_scripts
  echo "Node.js backend setup completed."
}
