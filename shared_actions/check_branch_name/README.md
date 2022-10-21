## check_branch_name

Checks the passed `branchName` if it complies with the [project branching strategy](https://confluence.nortal.com/display/BVU/New+branching+strategy).

##Inputs
### `branchName (required)`
**Required** The branch name to check

### `debug`
Whether to enable script debugging

##Outputs
### `valid` 
Whether the branch is valid or not [true|false]

##Usage

<pre>
    - name: Project setup
      with:
        branchName: ${{github.head_ref | github.ref_name }}
        debug: "true"
      uses: ./.github/actions/check_branch_name
</pre>


