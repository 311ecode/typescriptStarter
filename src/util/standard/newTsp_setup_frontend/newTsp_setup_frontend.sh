#!/bin/bash
newTsp_setup_frontend() {
  echo "Setting up frontend..."
  newTsp_setup_frontend_install_deps
  newTsp_setup_frontend_create_configs
  newTsp_setup_frontend_create_structure
  newTsp_setup_frontend_create_base_files
  newTsp_setup_frontend_create_components
  newTsp_setup_frontend_create_tests
  newTsp_setup_frontend_create_scripts
  echo "Frontend setup completed."
}