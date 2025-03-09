newTsp() {
  IFS=' ' read -r newTsp_project_name newTsp_typezero newTsp_node newTsp_help <<< "$(newTsp_parse_args "$@")"

  if [ "$newTsp_help" = "true" ]; then
    newTsp_help
    return 0
  fi

  if [ -z "$newTsp_project_name" ]; then
    echo "Error: Project name is required"
    echo "Use 'newTsp --help' for usage information"
    return 1
  fi
  
  if [ "$newTsp_typezero" = "true" ]; then
    newTsp_typezero_init "$newTsp_project_name"
  elif [ "$newTsp_node" = "true" ]; then
    newTsp_standard_init "$newTsp_project_name"
  else
    project_type=$(newTsp_select_project_type)
    case "$project_type" in
      "node")
        newTsp_standard_init "$newTsp_project_name"
        ;;
      *)
        echo "$project_type"
        ;;
    esac
  fi
}
