#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

main() {

  local files=()
  local total_passed=0
  local total_failed=0
  local total_tests=0

  for file in $(find shared_actions -name "test.sh"); do { files+=($file); } done

  echo "Found ${#files[@]} test files"

  if [[ ${#files[@]} -eq 0 ]]; then
    return 0;
  fi

  for test in "${files[@]}"; do {
    local passed=0
    local failed=0
    local action_name=$(echo "${test}" | cut -d "/" -f2)
    local results=$(eval $test)
    for results in $(echo "${results}" | tr ';' ' '); do {
      IFS="=" read -r -a arr <<< "${results}"
      declare "${arr[0]}"="${arr[1]}"
    } done

    total_passed=$(($total_passed + $passed))
    total_failed=$(($total_failed + $failed))

  } done

  total_tests=$(($total_failed + $total_passed))

  echo "Total tests: $total_tests, Passed: $total_passed, Failed: $total_failed"

  if [[ "$total_failed" -gt 0 ]]; then
     echo -e "\n${RED}$total_failed tests failed! ${NC}"
     exit 1;
  else
     echo -e "\n${GREEN}All $total_tests tests passed!${NC}"
  fi

}


main

