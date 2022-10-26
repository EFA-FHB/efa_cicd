## check_branch_name

Checks the passed `refName` for compliance with the [project branching strategy](https://confluence.nortal.com/display/BVU/New+branching+strategy).
If refName does not comply, action will exit with `exit code: 1` and will provide an error message with Confluence link to branc strategy.

## Inputs

Name | Mandatory | Description | Default | Example
-- | -- | -- | -- | --
`refName` | `yes` | Name of branch to check | | `feature/D603345-1104-github-actions-enforce-branching-strategy`, `${{github.ref_name}}`
`debug` | `no` | Whether to enable script debugging | `false` | 



##Usage

<pre>
    - name: Project setup
      with:
        refName: ${{ github.ref_name }}
        debug: "true"
      uses: ./.github/actions/check_branch_name
</pre>


