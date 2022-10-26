#!/bin/bash

REF_NAME=${REF_NAME:-}
DEBUG=${DEBUG:-false}

[[ "${DEBUG}" == "true" ]] && set -x

main() {

  if [[ "${REF_NAME}" =~ ^v([0-9]+\.){2}[0-9]+ ]]; then
    exit 0
  elif [[ "${REF_NAME}" =~ ^(main|development)$ ]]; then
    exit 0
  elif [[ "${REF_NAME}" =~ ^(feature|hotfix|bugfix)/D[0-9]+-[0-9]+[-_].+ ]]; then
    exit 0
  fi

  echo >&2 "REF_NAME '${REF_NAME}' does not comply with branch name strategy!"
  echo >&2 "For details on valid branch names, visit https://confluence.nortal.com/display/BVU/New+branching+strategy"
  exit 1
}

main