## docker_push_image

This action pushes a given image to a registry.

## Inputs

### `imageid`

## Usage

Building image with additonal tags

<pre>
      - name: Create image
        id: docker_push_image
        uses: ./.github/actions/docker_build_image
        with:
          imageid: registry.k8s-01.de.nortal.com/vergabesystem-hub-schema:1.1.0-4711
</pre>