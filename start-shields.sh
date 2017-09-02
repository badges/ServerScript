#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SHIELDS_DIR="$DIR/shields"
cd "$SHIELDS_DIR"
export HTTPS=true
export SHIELDS_ANALYTICS_FILE="$SHIELDS_DIR"/analytics-https.json
node --max_old_space_size=1380 ./server.js >> log/out \
  2> >( while read line; do date -u >> log/out; echo "$line" >> log/out; done )
