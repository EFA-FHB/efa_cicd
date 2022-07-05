# create_release

This creates a new release for the context repository.

##Inputs 
### `gpg_private_key`
**Required** GPG private key for commit and tag signing
### `gpg_passphrase`
**Required** GPG Passphrase to import private-key
### `token`
**Required** [Personal Accesss Token (PAT)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) to trigger the workflow.
### `name`
Name of the release. defaults to tag name
### `release_type`
**Required** Indicator of the release type. Must be any of the following strings: 
- major
- minor
- patch


## Outputs
None

## Usage

<pre>
      - name: create_release
        uses: ./.github/actions/create_release
        with:
          gpg_private_key: ${{secrets.BOT_GPG_PRIVATE_KEY}}
          gpg_passphrase: ${{secrets.BOT_GPG_PASSPHRASE}}
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          name: ${{inputs.release_name}}
          release_type: ${{inputs.release_type}}
</pre>