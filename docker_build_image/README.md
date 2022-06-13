## docker_build_image

This action creates and tags a container image using [docker](https://www.docker.com/).

## Inputs

### `image`

**Required** Value to use as name of the container image (without tag!) to create.

### `context`

**Required** Path to the docker build context. 

### `dockerfilePath`

**Required** Path to the Dockerfile to use  


**Note**:   
The `default tag` will match the following format: `version-buildnumber` where 
- `version` refers to the value of the attribute `version` extracted from the [gradle.properties](../../../gradle.properties)
- `buildnumber` refers to the value of the special env var `${{ github.run_number}}` 
 

## Outputs

### `docker_image`
The name of the container image created. The tag of the image is the `default tag`.

### `tags`
List of tag used to re-tag the image. Its value should equal to `${{ inputs.additionalTags }}`.


## Usage

Building image with additonal tags

<pre>
      - name: Create image
        id: docker_build_image
        uses: ./.github/actions/docker_build_image
        with:
          image: registry.k8s-01.de.nortal.com/vergabesystem-hub-schema
          context: schema
          dockerfilePath: schema/src/main/docker/Dockerfile
          additionalTags: "latest ${{ github.sha }}"
</pre>
 
Using the output to push the created container image

<pre>
  - name: Push image
    id: push_image
    shell: bash
    run: |
      docker push  ${{ steps.docker_build_image.outputs.docker_image }}
</pre>

Using the output to push the created container image and all tags

<pre>
  - name: Push image
    id: push_image
    shell: bash
    run: |
      origImage=${{ steps.docker_build_image.outputs.docker_image }}
      image_name=$(echo $origImage | cut -d":" -f1)

      IFS=', ' read -r -a tags <<< "${{ steps.docker_build_image.outputs.tags }}"
      for i in ${!tags[@]}; do {
          pushImage="$image_name:${tags[i]}"
          docker push $pushImage
       } done
</pre>



