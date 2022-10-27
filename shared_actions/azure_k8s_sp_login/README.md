# azure_k8s_sp_login

Github Action to connect with Azure Kubernetes Cluster using an dedicated Azure Service Principal. 
This action performs the following tasks: 
- login to Azure with Azure service principal credentials
- downloading credentials to connect to Azure Kubernetes Service
- downloading [kubelogin](https://github.com/Azure/kubelogin) to convert kubeconfig for service prinical login
- perform login to Azure Kubernetes Service

## Inputs 

### `az_sp_credentials`
**Required** Azure Service principal credentials
### `az_sp_client_id`
**Required** ClientId of Azure Service Principal 
### `az_sp_client_secret`
**Required** Client secret of Azure Service Principal
### `az_subscription_name`
**Required** Name of Azure Subscription to set
### `az_aks_resource_group`
**Required** Azure Resource group of Azure Kubernetes Service
### `az_aks_resource_name`
**Required** Name of Azure Kubernetes Service


## Outputs
None

## Usage

<pre>
...

jobs:

  aks_login:
  
    runs-on: ubuntu-latest
    
    steps: 
      - uses: actions/checkout@v3

      - name: install_shared_actions
        uses: ./.github/actions/install_shared_actions
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          tag: v1.3.0
      
      - name: login to AKS
        uses: ./.github/actions/shared/azure_k8s_sp_login
        with: 
           az_sp_credentials: ${{ secrets.AZURE_EFA_FHB_SP_AAD_CREDENTIALS }}
           az_sp_client_id: ${{ secrets.AZURE_EFA_FHB_SP_AAD_CLIENT_ID }}
           az_sp_client_secret: ${{ secrets.AZURE_EFA_FHB_SP_AAD_CLIENT_SECRET }}
           az_subscription_name: ${{ env.AZURE_SUBSCRIPTION_NAME }}
           az_aks_resource_group: ${{ env.AZURE_AKS_RESOURCE_GROUP }}
           az_aks_resource_name: ${{ env.AZURE_AKS_RESOURCE_NAME }}
</pre>