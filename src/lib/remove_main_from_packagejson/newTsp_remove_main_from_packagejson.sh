#!/bin/bash
newTsp_remove_main_from_packagejson() {
  local package_json_path="$1"

  if [[ -z $package_json_path ]]; then
    echo "Error: Package.json path not provided."
    return 1
  fi

  if [[ ! -f $package_json_path ]]; then
    echo "Error: Package.json file not found at '$package_json_path'."
    return 1
  fi

  # Check if "main" key exists before attempting to remove it
  if jq 'has("main")' "$package_json_path" | grep -q "true"; then
    # Use jq to remove the "main" key
    local temp_file=$(mktemp)
    jq 'del(.main)' "$package_json_path" >"$temp_file"

    if [[ $? -ne 0 ]]; then
      echo "Error: Failed to process package.json with jq."
      rm -f "$temp_file"
      return 1
    fi

    # Replace the original file with the modified version
    mv "$temp_file" "$package_json_path"

    echo "Successfully removed 'main' key from '$package_json_path'."
    return 0
  else
    # Main key not found, don't output anything
    return 0
  fi
}