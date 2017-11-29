#!/bin/bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ips=$(< "$DIR"/../private/secret.json jq -r .shieldsIps[])

if [[ -z "$1" || "$1" == --help ]]; then
  echo 'Usage: in-each-server-do.sh [bash command]'
  echo
  echo 'The bash command is run in each server.'
  echo 'The IP address of the current server is in $IP.'
  exit 1
fi

for ip in $ips; do
  ssh root@"$ip" 'export IP='"$ip"'; '\ "$1"
done
