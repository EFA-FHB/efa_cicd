## create_image_tags

Produces a comma delimited string of tags calculated from the passed `inputs`.
The tags produced comply with the [project branching strategy](https://confluence.nortal.com/display/BVU/New+branching+strategy)

The tags are meant to be used for `docker build` or `docker tag` operations. 

##Inputs
### `branchName (required)`
**Required** The branch name to check

### `buildNumber (required)`
**Required** The current build number

### `semver (required)`
**Required** A version number in accordance with Semantic Versioning [semver 2.0](https://semver.org/)

### `debug`
Whether to enable script debugging

##Outputs
### `tags` 
Comma delimited string of tags.  


##Usage

<pre>
    - name: create image tags
      with:
        branchName: ${{github.head_ref | github.ref_name }}
        buildNumber: ${{ github.run_number }}
        semver: "1.2.3-SNAPSHOT"
        debug: "true"
      uses: ./.github/actions/create_image_tags
</pre>


