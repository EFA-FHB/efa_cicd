#!/bin/bash -e

for type in old new; do {

  if [[ "$type" == "new" ]]; then
    subscr_id="${DEST_ACR_SUBSCRIPTION_ID}"
    acr_name="${DEST_ACR_RESOURCE_NAME}"
  else
    subscr_id="${SOURCE_ACR_SUBSCRIPTION_ID}"
    acr_name="${SOURCE_ACR_RESOURCE_NAME}"
  fi

  az account set -n $subscr_id
  echo "Fetching repostories of registry $acr_name..."

  repos=$(az acr repository list -n "$acr_name" | jq .[] | tr -d '"')

  for repo in $repos; do {
    echo "Fetching tags for repo $repo..."
    tags=$(az acr repository show-tags -n "$acr_name" --repository $repo | jq .[] | tr -d '"')
    for tag in $tags; do {
      echo "$repo:$tag" >> "$type"_images.txt
      echo "Preparing sync for image: $(tail -1 "$type"_images.txt)"
    } done

  } done

} done

while read -r -a image; do {
  echo "Checking image $image..."
  grep -E "$image" new_images.txt -q
  if [[ $(echo $?) -eq 0 ]]; then
    echo "Import needed"
    echo $image >> images_to_sync.txt
  else
    echo "Already imported, skipping..."
  fi

} done << old_images.txt

echo "Found $(wc -l images_to_sync.txt) images to import"

az account set -n "${DEST_ACR_SUBSCRIPTION_ID}"

n=0;
while read -r -a image; do {
  echo "Importing image $image to ${DEST_ACR_RESOURCE_NAME}"
  az acr import \
     --name "${DEST_ACR_RESOURCE_NAME}" \
     --source "$image" \
     --image "$image" \
     --registry "/subscriptions/${SOURCE_ACR_SUBSCRIPTION_ID}/resourceGroups/${SOURCE_ACR_RESOURCE_GROUP}/providers/Microsoft.ContainerRegistry/registries/${SOURCE_ACR_RESOURCE_NAME}"
  n=$(($n + 1));
  echo "Import done for $image"
} << done images_to_sync.txt

echo "Total count of imported tags: $n"


