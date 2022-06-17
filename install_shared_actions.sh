#!/bin/bash

# Github actions which reference special Github-Action contexts like ${{secret.*}} will
# not work if they are not present inside the .github/actions of the repository which uses
# it.
#
# This script will copy all Github-Actions inside "actions" directory over to another repository's
# Github-Actions directory, which enables usage of those actions in the workflows defined inside
# repository.
#
# ACTIONS_TARGET_DIR must be a directory which ends with either ".github" or ".github/actions".
# The path specified by ACTIONS_TARGET_DIR will be created if it does not yet exist.
#
function help() {
  echo "Options: "
  echo -e "--copy_target_dir \t required - Path of directory to copy all actions to"
  echo -e "\n Usage: ACTIONS_TARGET_DIR=../target $0"
  exit 1;
}

SHARED_ACTIONS_DIR="shared_actions"

function main() {
  [[ -z "${ACTIONS_TARGET_DIR}" ]] && {
    echo "ACTIONS_TARGET_DIR not defined!" && help
  }

  echo "${ACTIONS_TARGET_DIR}" | grep -E ".github/?$|.github/actions$" -q
  [[ $(echo $?) -ne 0 ]] && {
    echo "ACTIONS_TARGET_DIR is not a valid github actions directory" && help
  }

  [[ ! "${ACTIONS_TARGET_DIR}" =~ actions$ ]] && {
    ACTIONS_TARGET_DIR="${ACTIONS_TARGET_DIR}/actions"
  }

  mkdir -p "${ACTIONS_TARGET_DIR}"

  cd $(dirname "$0")
  for action in $(find "${SHARED_ACTIONS_DIR}" -type d | awk 'NR > 1'); do {
    action_name=$(echo "${action}" | cut -d "/" -f2)
    echo "copying action \"${action_name}\" to ${ACTIONS_TARGET_DIR}"
    cp -r "${action}" "${ACTIONS_TARGET_DIR}";
  } done
}

main "${@}"








