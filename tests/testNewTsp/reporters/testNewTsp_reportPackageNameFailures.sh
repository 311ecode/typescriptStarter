#!/bin/bash
testNewTsp_reportPackageNameFailures() {
  local package_name_result=$1

  if [ $package_name_result -ne 0 ]; then
    echo "  ❌ PACKAGE NAME TEST FAILURES:"
    echo "     - Package name handling is not working correctly"
    echo "     - Check directory name sanitization"
    echo "     - Verify package.json name property is set correctly"
    echo "     - Make sure trailing dashes are removed"
  fi
}
