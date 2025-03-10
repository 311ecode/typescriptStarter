newTsp_setup_frontend() {
  echo "Setting up frontend..."
  # Skip common dependency installation since it's already done
  newTsp_setup_frontend_install_deps # Frontend-specific dependencies only
  newTsp_setup_frontend_create_configs
  newTsp_setup_frontend_create_structure
  newTsp_setup_frontend_create_base_files
  newTsp_setup_frontend_create_components
  newTsp_setup_frontend_create_tests
  newTsp_setup_frontend_create_scripts
  echo "Frontend setup completed."
}