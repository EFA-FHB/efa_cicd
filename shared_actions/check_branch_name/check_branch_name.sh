#!/bin/bash

BRANCH_NAME=${BRANCH_NAME:-}
DEBUG=${DEBUG:-false}

[[ "${DEBUG}" == "true" ]] && set -x

main() {

  local result=

  if [[ "${BRANCH_NAME}" =~ ^(main|development)$ ]]; then
    result=true
  elif [[ "${BRANCH_NAME}" =~ ^(feature|hotfix|bugfix)/D[0-9]{6}-[0-9]+-.+ ]]; then
    result=true
  else
    result=false
  fi


  echo "${result}"
}

main