#!/bin/bash
newTsp_setup_node() {
  echo "Setting up Node.js backend..."
  newTsp_setup_node_install_deps
  newTsp_setup_node_create_configs
  newTsp_setup_node_create_structure
  newTsp_setup_node_create_files
  newTsp_setup_node_create_tests
  newTsp_setup_node_update_package
  echo "Node.js backend setup completed."
}

