## cleanup_workflow_runs

This action deletes old workflow runs of a specified repository using Github's REST API.

It first fetches a complete list of workflow runs from the Github REST-API. 
 
Then it slices the list and extracts all but the most recent 30 runs`. 

The extracted run are deleted one by one starting from the oldest.
 
 
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

      - name: cleanup_workflow_runs
        uses: ./.github/actions/cleanup_workflow_runs
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          repo: "EFA-FHB/vergabesystem-adapter"
</pre>



