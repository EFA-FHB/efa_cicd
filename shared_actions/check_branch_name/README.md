## check_branch_name

Checks if the branch name targeted by the workflow run is in compliance with the [project branching strategy](https://confluence.nortal.com/display/BVU/New+branching+strategy).
If it does not comply, action will exit with `exit code: 1` and will provide an error message with Confluence link to branc strategy.

## Inputs

Name | Mandatory | Description | Default | Example
-- | -- | -- | -- | --
`debug` | `no` | Whether to enable script debugging | `false` | 



##Usage

<pre>
    - name: Project setup
      with:
        debug: "true"
      uses: ./.github/actions/check_branch_name
</pre>


