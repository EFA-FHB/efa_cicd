## trigger_deploy_workflow

This action triggers a deployment workflow located in [k8s_workflows](https://github.com/EFA-FHB/k8s_workflows). 

## Inputs
### `tag`
Name of tag to be passed to deployment workflow.

### `tag-file-name`
Filename from which a tag can be extracted.  

The file will be downloaded using `actions/download-artifact` Github-Action.

### `stage`
Stage to deploy to. Defaults to "dev".

### `token`
Github [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
required to trigger the deployment.  

### `workflow`
Name of workflow to trigger. 

## Usage

<pre>
      - name: trigger deployment
        id: trigger_deployment
        uses: ./.github/actions/trigger_deploy_workflow
        with:
          tag: '2.0.0'
          tag-file-name: 'pushed_tags.txt'
          token: '${{secrets.REPO_ACCESS_TOKEN}}'
          stage: 'dev' 
          workflow: 'deploy_bkms-mediator'
</pre>