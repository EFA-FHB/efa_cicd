#!/bin/bash

cd $(dirname "$0")/..

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"

failed=0
passed=0

test() {

  local expected_result=

  local REF_NAME=

  for args in $(echo "${@}" | tr ';' ' '); do {
   IFS="=" read -r -a arr <<< "${args}"
   declare "${arr[0]}"="${arr[1]}"
  } done

  local check="input: '$2'\n"


  export REF_NAME=${REF_NAME}

  local actual_result=
  actual_result=$(./check_branch_name.sh)
  local actual_exit="$?"

  local pass=false

  if [[ -n "${expected_result}" ]]; then
    check="${check}expected result: '${expected_result}'\nactual: '${actual_result}'"
    [[ "${expected_result}" == "${actual_result}" ]] && pass=true
  fi

  if [[ "${pass}" == true ]]; then
    passed=$(($passed + 1))
    check="${check}\n${GREEN}result: pass${NC}"
  else
    failed=$(($failed + 1))
    check="${check}\n${RED}result: fail${NC}"
  fi

  echo >&2 -e "\n${check}"




}


main() {

  test "expected_result=true" "REF_NAME=main"
  test "expected_result=true" "REF_NAME=development"
  test "expected_result=true" "REF_NAME=feature/D603345-6-setup-shared-base-docker-images"
  test "expected_result=true" "REF_NAME=bugfix/D603345-6-setup-shared-base-docker-images"
  test "expected_result=true" "REF_NAME=hotfix/D603345-6_setup-shared-base-docker-images"

  test "expected_result=false" "REF_NAME=master"
  test "expected_result=false" "REF_NAME=main/foobar"
  test "expected_result=false" "REF_NAME=development/foobar"
  test "expected_result=false" "REF_NAME=feature/main"
  test "expected_result=false" "REF_NAME=hotfix/setup-shared-base-docker-images"
  test "expected_result=false" "REF_NAME=hotfix/[D603345-6]-setup-shared-base-docker-images"
  test "expected_result=false" "REF_NAME=hotfix/603345-6-setup-shared-base-docker-images"
  test "expected_result=false" "REF_NAME=hotfix/D603345-setup-shared-base-docker-images"

  test "expected_result=true" "REF_NAME=v5.0.0"
  test "expected_result=false" "REF_NAME=5.0.0"
  test "expected_result=false" "REF_NAME=v5.0"
  test "expected_result=false" "REF_NAME=v5"


  echo "passed=${passed};failed=${failed}"

}

main

