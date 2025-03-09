newTsp_init_npm() {
  local project_name="$1"
  
  npm init -y
  
  # Update package name
  jq --arg name "$project_name" '.name = $name' package.json > temp.json && mv temp.json package.json
  
  # Add basic shared scripts
  jq '.scripts += {
    "lint": "ts-standard",
    "lint:fix": "ts-standard --fix",
    "format": "prettier --write \"src/**/*.{ts,tsx,css}\""
  }' package.json > temp.json && mv temp.json package.json
  
  # Set module type to ES Modules
  jq '. += {
    "type": "module"
  }' package.json > temp.json && mv temp.json package.json
}