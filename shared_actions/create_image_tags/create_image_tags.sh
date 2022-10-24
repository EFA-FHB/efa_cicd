#!/bin/bash

DEBUG=${DEBUG:-false}
RED="\033[0;31m"
NC="\033[0m"

[[ "${DEBUG}" == "true" ]] && set -x


main() {
  _check_env_vars
  echo $(_create_tags)
}

_create_tags() {

  tags=()

  local version_core=$(_extract_version_core)

  if [[ ${BRANCH_NAME} == "main" ]]; then
    tags+=("${version_core}-${BUILD_NUMBER}")
  fi

  if [[ ${BRANCH_NAME} == "development" ]]; then
    tags+=("${version_core}-beta-${BUILD_NUMBER} latest")
  fi

  if [[ ${BRANCH_NAME} =~ ^(feature|hotfix|bugfix)/.+ ]]; then
    local issue_number=$(_extract_issue_number)
    local branch_prefix=$(_extract_branch_prefix)
    tags+=("${branch_prefix}-${issue_number}-${BUILD_NUMBER}" "${branch_prefix}-${issue_number}-latest")
  fi

  echo "${tags[@]}" | tr ' ' ','

}


_check_env_vars() {
  local errors=()
  [[ -z "${BUILD_NUMBER}" ]] && errors+=(BUILD_NUMBER)
  [[ -z "${SEMVER}" ]] && errors+=(SEMVER)
  [[ -z "${BRANCH_NAME}" ]] && errors+=(BRANCH_NAME)

  [[ ${#errors} -gt 0 ]] && {
    echo >&2 -e "${RED}Missing required args: [${errors[*]}]${NC}"
    exit 1;
  }

  _check_semver

}

_check_semver() {

  local version_core=$(_extract_version_core)

  if [[ "${version_core}" =~ ^([0-9]+\.){2}[0-9]+$ ]]; then
    local pre_release=$(echo "${SEMVER}" | sed -E "s/${version_core}//")
    if [[ -z "${pre_release}" || "${pre_release}" =~ ^[-+][a-zA-Z0-9]+(\.[a-zA-Z0-9]+){0,}$ ]]; then
      return 0
    fi
  fi

  echo >&2 -e "${RED}Version '${SEMVER}' does not seem to be valid version (semver 2.0)${NC}"
  exit 1
}

_extract_version_core() {
  echo "${SEMVER}" | sed -E 's/^([^.]+\.[^.]+\.[^-+]+).+/\1/'
}

_extract_issue_number() {
  echo "${BRANCH_NAME}" | sed -E 's/^.+\/(D[0-9]{6}-[0-9]+).+$/\1/'
}

_extract_branch_prefix() {
  echo "${BRANCH_NAME}" | sed -E 's/^(feature|hotfix|bugfix)\/.+/\1/'
}

main