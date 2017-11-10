#!/bin/bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ips=$(< "$DIR"/../private/secret.json jq -r .shieldsIps[])
for ip in $ips; do
  scp root@"$ip":/home/m/shields/private/github-user-tokens.json "$ip"
done

echo "$ips" | xargs jq -s 'add|unique'

for ip in $ips; do
  rm "$ip"
done
