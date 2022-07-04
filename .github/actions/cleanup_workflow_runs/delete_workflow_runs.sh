#!/bin/bash -e

args=(-H "Accept: application/vnd.github+json" -H "Authorization: token ${TOKEN}")

page=1
workflow_runs="-1"

while [ true ]; do
  curl "${args[@]}" "https://api.github.com/repos/${REPOSITORY}/actions/runs?page=$page&per_page=100" > workflow_runs.tmp
  workflow_runs="$(jq '.workflow_runs | length' workflow_runs.tmp)"
  page=$(($page+1))
  jq < workflow_runs.tmp "[.workflow_runs[] | {url: .url, created_at: .created_at}]" > list.tmp
  [[ ! -f all.txt ]] && touch all.txt
  jq -n '[inputs]  | add' all.txt list.tmp > all.tmp
  mv all.tmp all.txt
  echo "items saved: $(cat all.txt | wc -l)"
  if [[ "${workflow_runs}" -eq 0 ]]; then
    break;
  fi
done

RETAIN_MAX_DAYS=${RETAIN_MAX_DAYS:-30}
days_ago=$(($(date +%s) - $((86400*$RETAIN_MAX_DAYS))))

jq < all.txt ".[] | select (.created_at | fromdateiso8601 < $days_ago).url" | tr -d '"' > url_for_delete.txt

count=$(cat url_for_delete.txt | wc -l)
echo "start deleting $count urls"
#
while read url; do {
  curl -X DELETE "${args[@]}" "$url"
  count=$((count-1))
} done < url_for_delete.txt

echo "done!"
