## import_container_images

This action fetches container image manifests and tags from one Azure Container Registry (ACR)
and imports them to another. 

 
## Inputs

### `source_acr_subscription_id`

**Required** Azure Subscription Id of source container registry
### `source_acr_resource_group`
**Required** Azure Resource group of source container registry

### `source_acr_resource_name`
**Required** Name of source container registry

### `dest_acr_subscription_id`
**Required** Azure Subscription Id of target container registry

### `dest_acr_resource_group`
**Required** Azure Resource group of target container registry

### `dest_acr_resource_name`
**Required** Name of target container registry

##Outputs
None

## Usage

<pre>
    steps:

      - uses: actions/checkout@v3

      - uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_EFA_FHB_SP_CREDS }}

      - name: import container images
        uses: .github/actions/import_container_images
        with:
          source_acr_subscription_id: 1d49c337-1058-4fe0-997f-fb7263956e13
          source_acr_resource_group: efa-bremen-oeffentliche-vergabe
          source_acr_resource_name: efabremenoeffentlichevergabedev
          dest_acr_subscription_id: 006eefc2-3b28-4a09-80e1-b8d6f23584d2
          dest_acr_resource_group: efa-fhb
          dest_acr_resource_name: efafhb
</pre>



