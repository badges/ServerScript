#!/bin/bash

rm -rf /root/.cache/bower
for f in $(ls /tmp); do
  if [ -d /tmp/"$f"/bower ]; then
    echo "$f"
    rm -rf /tmp/"$f"/
  fi
done
