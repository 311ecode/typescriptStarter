newTsp_standard_init() {
  local folder_name="$1"

  mkdir "$folder_name"
  cd "$folder_name" || exit

  newTsp_setup_common "$folder_name"
  newTsp_create_index_ts
  newTsp_create_jest_config

  echo "
  Project initialized successfully at:
  "
  pwd
  cd ..
}