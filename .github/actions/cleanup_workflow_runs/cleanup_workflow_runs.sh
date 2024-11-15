#!/bin/bash

args=(-sS -H "Accept: application/vnd.github+json" -H "Authorization: token ${TOKEN}")

page=1
workflow_runs="-1"

total_run_count=0

while [ true ]; do
  curl "${args[@]}" "https://api.github.com/repos/${REPOSITORY}/actions/runs?page=$page&per_page=100" > workflow_runs.tmp
  workflow_runs="$(jq '.workflow_runs | length' workflow_runs.tmp)"
  page=$(($page+1))
  jq < workflow_runs.tmp "[.workflow_runs[] | {url: .url, created_at: .created_at}]" > list.tmp
  [[ ! -f all.txt ]] && touch all.txt
  jq -n '[inputs]  | add' all.txt list.tmp > all.tmp
  mv all.tmp all.txt
  total_run_count=$(cat all.txt | jq '. | length')
  echo "runs collected so far: $total_run_count"
  if [[ "${workflow_runs}" -eq 0 ]]; then
    break;
  fi
done

echo "Got ${total_run_count} runs for repository ${REPOSITORY}"

retain_max_run_count=${RETAIN_MAX_RUN_COUNT:-0}

if [[ "${retain_max_run_count}" -lt 30 ]]; then
  #keep the last thirty runs
  retain_max_run_count=30
fi

delete_run_count=$(($total_run_count - $retain_max_run_count))
echo "Will delete ${delete_run_count} workflow runs..."

cat all.txt | jq '.[] | .url' | tr -d '"' | tail -n ${delete_run_count} | sort > url_for_delete.txt

while read url; do {
  echo "delete ${url}"
  curl -X DELETE "${args[@]}" "$url"
  count=$((count-1))
} done < url_for_delete.txt

echo "Done!"
echo "Deleted $(cat url_for_delete.txt | wc -l)"
exit 0;