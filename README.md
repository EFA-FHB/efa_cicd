# efa_cicd
Shared workflows, actions and utilities supporting CI/CD related tasks in scope of project

## Motivation

This project provides several actions inside the `shared_actions` folder, which contain
actions for common usecases such as building and pushing docker images. 

The github actions inside `shared_actions` folder were previously maintained separately in various projects inside [EFA-FHB] organization, 
which lead to a lot of duplication. They have been extracted to this repository to centralize management and reference in
other projects of [EFA-FHB] organization.

## Shared actions
This repository currently contains the following shared actions: 
- [azure_k8s_sp_login](shared_actions/azure_k8s_sp_login/README.md)
- [setup_jdk_17](shared_actions/setup_jdk_17/README.md)
- [gradle_xray_test](shared_actions/gradle_xray_test/README.md)
- [docker_build_image](shared_actions/docker_build_push_image/README.md)
- [create_release](shared_actions/create_release/README.md)
- [trigger_deploy_workflow](shared_actions/trigger_deploy_workflow/README.md)
- [check_branch_name](shared_actions/check_branch_name/README.md)
- [create_image_tags](shared_actions/create_image_tags/README.md)
- [get_version](shared_actions/get_version/README.md)

## Installation

Repos can import the shared actions into their `.github` folder using the bash script [install_shared_actions.sh](install_shared_actions.sh).

To install all shared actions during a workflow run: 
- checkout repository
- execute install_shared_actions.sh 

```yaml
    - uses: actions/checkout@v3
      name: Checkout cicd repo
      with:
        repository: EFA-FHB/efa_cicd
        token: ${{ inputs.token }}
        path: efa_cicd

    - name: install shared actions
      env:
        ACTIONS_TARGET_DIR: ${{github.workspace}}
      shell: bash
      run: efa_cicd/install_shared_actions.sh
```


