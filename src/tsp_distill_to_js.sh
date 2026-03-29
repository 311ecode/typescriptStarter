#!/usr/bin/env bash

tsp_distill_to_js() {
    # We escape the $ here so it isn't eval'd until the function is actually called
    command -v markdown-show-help-registration &>/dev/null && eval "$(markdown-show-help-registration)"
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local js_path="${script_dir}/tsp_distill_to_js.js"

    if [[ ! -f "$js_path" ]]; then
        echo "Error: tsp_distill_to_js.js not found at $js_path" >&2
        return 1
    fi

    if ! command -v node &> /dev/null; then
        echo "Error: node is not installed" >&2
        return 1
    fi

    node "$js_path" "$@"
}
## created by util/make_bash_wrapper.sh 
