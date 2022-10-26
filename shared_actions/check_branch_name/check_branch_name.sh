#!/bin/bash

REF_NAME=${REF_NAME:-}
DEBUG=${DEBUG:-false}

[[ "${DEBUG}" == "true" ]] && set -x

main() {

  local result=

  if [[ "${REF_NAME}" =~ ^v([0-9]+\.){2}[0-9]+ ]]; then
    result=true
  elif [[ "${REF_NAME}" =~ ^(main|development)$ ]]; then
    result=true
  elif [[ "${REF_NAME}" =~ ^(feature|hotfix|bugfix)/D[0-9]+-[0-9]+[-_].+ ]]; then
    result=true
  else
    result=false
  fi


  echo "${result}"
}

main