## docker_build_image

This action creates and tags a container image using [docker](https://www.docker.com/).
The tag used for the image is constructed from reading a property `version` and the buildnumber
of the current build run `${{github.run_number}}`.

The value `version` property is extracted from a file `gradle.properties` or `package.json` expected in the 
root of the project using calling that action. 

Unless the action is called during a build of `main` or `release` branch 
the tag contains the normalized name for the feature-branch. 

```bash
//Examples

// on branch `main` 
2.0.0-241

//on branch 'workflow/efa_cicd'
2.0.0-workflow-efa-cicd-5
```

## Inputs


### `image`

**Required** Value to use as name of docker container image.

### `context`

**Required** Path to use as docker build context. 

### `dockerfilePath`

**Required** Path of DockerFile

### `scanImage`

Whether to scan the newly built docker image for vulnerabilties (`default: true`)
 

## Outputs

### `docker_image`
The name of the container image created (including the tag).


## Usage

Building image with additonal tags

<pre>
      - name: docker build image
        id: build_image
        uses: ./.github/actions/docker_build_image
        env:
          image: ${{steps.workload.outputs.image}}
          context: ${{steps.workload.outputs.context}}
          dockerfilePath: ${{steps.workload.outputs.dockerfilePath}}
        with:
          image: ${{env.AZURE_DOCKER_REGISTRY}}/bkms-mediator-app
          context: app
          dockerfilePath: app/src/main/docker/Dockerfile.jvm
          scanImage: false
</pre>



