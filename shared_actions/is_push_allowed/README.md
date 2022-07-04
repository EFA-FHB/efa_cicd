## docker_push_image

This action pushes a given image to a registry.

## Inputs

### `imageid`
**Required** Reference of the docker image to push

### `tag-file-name`
**Required** Name of the file to upload after the docker image was successfully pushed. 
The file will be uploaded to github using [actions/upload-artifact](https://github.com/actions/upload-artifact) Github action.  
The file will contain the name of all tags from which the newly referenced image is retrievable.

## Outputs
###tag
Tag of the pushed docker image

## Usage

<pre>
      - name: docker push image
        id: push_image
        uses: ./.github/actions/docker_push_image
        with:
          imageid: ${{ steps.build_image.outputs.docker_image }}
          tag-file-name: ${{env.TAG_FILE}}
</pre>