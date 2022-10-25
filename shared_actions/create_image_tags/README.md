## create_image_tags

Produces a space separated string of tags calculated from the passed `inputs`.
The tags produced comply with the [project branching strategy](https://confluence.nortal.com/display/BVU/New+branching+strategy)

The tags can be used for `docker build` or `docker tag` operations. 

## Inputs

Name | Mandatory | Description | Default | Example
-- | -- | -- | -- | --
`branchName` | `yes` | Name of branch to check | | `feature/D603345-1104-github-actions-enforce-branching-strategy`, `${{github.ref_name}}`
`buildNumber` | `yes` | The current build number | | `12`, `${{ github.run_number }}`
`semver` | `yes` | A version number complying with [Semver 2.0](https://semver.org/)
`debug` | `no` | Whether to enable script debugging | `false` | 

## Outputs

Name | Description | Example
-- | -- | -- 
`tags` | Space separated list of image tags | `2.0.0-beta-123 latest`, `2.0.0-213` [More examples](https://confluence.nortal.com/display/BVU/New+branching+strategy)

##Usage

<pre>
      - name: get version
        id: get_version
        uses: ./.github/actions/get_version
        with:
          versionFileName: "gradle.properties"

      - name: create image tags
        id: create_image_tags
        uses: ./.github/actions/create_image_tags
        with:
          semver: ${{steps.get_version.outputs.version}}
          branchName: ${{ github.ref_name }}
          buildNumber: ${{ github.run_number }}
</pre>


