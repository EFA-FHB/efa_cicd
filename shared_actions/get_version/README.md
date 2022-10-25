## get_version

Parses a version number from a specified file.
The specified file is looked up in the project root (`${{github.workspace}}`).

The following files are supported:
- `gradle.properties`
- `package.json`

The file _must_ exist in the `${{github.workspace}}` (resolves to project root).

## Inputs

Name | Mandatory | Description | Default | Example
-- | -- | -- | -- | --
`versionFileName` | `yes` | Name of version file to extract version information from. | | `gradle.properties` or `package.json`

## Outputs

Name | Description | Example
-- | -- | -- 
`version` | The extracted version information | `1.0.0`


##Usage

<pre>
      - name: get version
        id: get_version
        uses: ./.github/actions/get_version
        with:
          versionFileName: "gradle.properties"
</pre>


