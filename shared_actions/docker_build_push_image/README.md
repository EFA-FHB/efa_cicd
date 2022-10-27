## docker_build_push_image

This actions performs the following operations: 
- building and tagging Docker container image
- Optionally, scanning and/or pushing the previously created image

## Inputs

Name | Mandatory | Description | Default | Example
-- | -- | -- | -- | --
`image` | `yes` | Name of docker image _without_ tag reference (Format: `<host>/<repository>`) | | `efafhb.azurecr.io/bkms-mediator-app`
`imageTags` | `yes` | Tags used for tagging the `image`. Provide multiple tags separated with `space` | | `1.2.3-123` or `1.2.3-232 latest`
`context` | `yes` | Path to use as docker build context | | `schema`
`dockerfilePath` | `yes` | Path to Dockerfile  | | `schema/src/main/docker/Dockerfile.jvm`
`scanImage` | `no` | Whether to scan the created docker image with [Trivy](https://aquasecurity.github.io/trivy). | `true` | 
`pushImage` | `no` | Whether to push the created docker manifest and its associated tags | `true` | 
 
## Outputs

Name | Description | Example
-- | -- | -- 
`digest` | Image digest of created docker manifest | `sha256:880c34aa6a1ca9496ddad1bc8f2cbbbc2250d3c84c5a41e2b3516c099ca92df8`
`tags` | Space separated list of tags used to tag the created docker manifest | `1.2.3-123` or `1.2.3-232 latest`

## Usage

**Build and tag image with 'latest'**

<pre>
      - name: install_shared_actions
        uses: ./.github/actions/install_shared_actions
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          
      - name: docker build image
        id: build_image
        uses: ./.github/actions/shared/docker_build_push_image
        with:
          image: ${{env.AZURE_DOCKER_REGISTRY}}/bkms-mediator-app
          imageTags: "latest"
          context: app
          dockerfilePath: app/src/main/docker/Dockerfile.jvm
</pre>

**Build and tag image (without security scan)**

<pre>  
      - name: install_shared_actions
        uses: ./.github/actions/install_shared_actions
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          
      - name: docker build image
        id: build_image
        uses: ./.github/actions/docker_build_push_image
        with:
          image: ${{env.AZURE_DOCKER_REGISTRY}}/bkms-mediator-app
          imageTags: "latest"
          context: app
          dockerfilePath: app/src/main/docker/Dockerfile.jvm
          scanImage: false
</pre>

**Build and tag image (without 'docker push')**

<pre>
      - name: install_shared_actions
        uses: ./.github/actions/install_shared_actions
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          
      - name: docker build image
        id: build_image
        uses: ./.github/actions/docker_build_push_image
        with:
          image: ${{env.AZURE_DOCKER_REGISTRY}}/bkms-mediator-app
          imageTags: "latest"
          context: app
          dockerfilePath: app/src/main/docker/Dockerfile.jvm
          pushImage: false
</pre>
