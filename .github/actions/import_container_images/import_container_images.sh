#!/bin/bash -e

touch new_images.txt
touch old_images.txt

for type in old new; do {

  if [[ "$type" == "new" ]]; then
    subscr_id=$NEW_ACR_SUBSCRIPTION_ID
    acr_name=$NEW_ACR_RESOURCE_NAME
  else
    subscr_id=$OLD_ACR_SUBSCRIPTION_ID
    acr_name=$OLD_ACR_RESOURCE_NAME
  fi

  az account set -n $subscr_id

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
  grep -E "$image" new_images.txt -q
  [[ $(echo $?) -eq 0 ]] && echo $image >> images_to_sync.txt
} done << old_images.txt

echo "Found $(wc -l images_to_sync.txt) images to import"

az account set -n "${NEW_ACR_SUBSCRIPTION_ID}"

n=0;
while read -r -a image; do {
  echo "Importing image $image to ${NEW_ACR_NAME}"
  az acr import \
     --name ${NEW_ACR_NAME} \
     --source $repo:$tag \
     --image $repo:$tag \
     --registry /subscriptions/${OLD_ACR_SUBSCRIPTION_ID}/resourceGroups/${OLD_ACR_RESOURCE_GROUP}/providers/Microsoft.ContainerRegistry/registries/${OLD_ACR_RESOURCE_NAME}
  n=$(($n + 1));
  echo "Import done for $image"
} << done images_to_sync.txt

echo "Total count of imported tags: $n"


