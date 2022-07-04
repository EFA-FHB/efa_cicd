## cleanup_workflow_runs

This action deletes old workflow runs of a specified repository using Github's REST API.

It first fetches a complete list of workflow_runs, it then creates a list of deletable workflow runs 
based on the current date. (Any workflow run older than _30 days_ will be deleted.)
It then issues a DELETE-Requests for each of deleteable runs.   
 
## Inputs

### `token`

**Required** The [Personal Access Token (PAT)]() to pass in the `Authorization`-header when calling the Github REST API. 

### `repo`

**Required** Name of repository. 

### `max-retain-days`

A workflow's age in days must be greater than this value in order for it to be deleted.

##Outputs
None

## Usage

<pre>
    steps:

      - uses: actions/checkout@v3

      - name: delete_workflow_runs
        uses: ./.github/actions/cleanup_workflow_runs
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          repo: "EFA-FHB/vergabesystem-adapter"
</pre>



