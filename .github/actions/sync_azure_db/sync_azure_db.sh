#!/bin/bash -e


#1
echo "set namespace to ${K8S_NAMESPACE}..."
kubectl config set-context --current --namespace "${K8S_NAMESPACE}"

echo "retrieving pod..."
pod=$(kubectl get pods -lapp=postgres-client -oname | cut -d "/" -f2)
echo "got pod ${pod}"

exec="kubectl exec $pod"

for app in bkms-mediator vergabesystem-adapter; do {

  echo -e "retrieving psql_wrapper for ${app}...\n"
  psql_cli=$($exec -- sh -c "cat ~/.bashrc | grep -E "${app}" | cut -d "=" -f2 | tr -d ''\'")
  echo "creating dump file..."
  dump_file="${app}_$(date +%F_%T | sed 's/:/_/g').dump"
  $exec -- sh -c "$psql_cli pg_dump -h ${SOURCE_DB_HOST} -Fc -f ${dump_file} --clean -n public -x"
  echo "Importing dump file..."
  $exec -- sh -c "$psql_cli pg_restore -h ${TARGET_DB_HOST} -c < ${dump_file} || true"
  $exec -- sh -c "rm ${dump_file}"
  echo -e "\nDump file successfully imported!"

} done