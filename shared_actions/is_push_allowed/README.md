## is_push_allowed

This action checks inspects specific env vars to determine whether a Docker image can be pushed.

The action returns an output field `result` which returns `true` if
- `$GITHUB_REF` points to branch `refs/heads/main`
- `$GITHUB_REF` points to a branch `refs/heads/release/**`
- `$GITHUB_REF` points to tag `refs/tags/**`
- `$PUSH_IMAGE` resolves to `true`

Otherwise, `result` returns `false`.
## Inputs

None 

## Outputs

### `result (boolean)`

Indicator of whether a docker image produced during a worklow run which executes this action 
can be pushed to a container registry.

## Usage

<pre>
      - name: docker push image
        id: push_image
        uses: ./.github/actions/docker_push_image
        with:
          imageid: ${{ steps.build_image.outputs.docker_image }}
          tag-file-name: ${{env.TAG_FILE}}
</pre>