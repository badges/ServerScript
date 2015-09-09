#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SHIELDS_DIR="$DIR/shields"
pushd "$SHIELDS_DIR"
forever start -a \
  -l "$SHIELDS_DIR"/log/forever.log \
  -o "$SHIELDS_DIR"/log/out.log \
  -e "$SHIELDS_DIR"/log/err.log \
  --minUptime 1000 --spinSleepTime 1000 \
  server.js
export HTTPS=true
export SHIELDS_ANALYTICS_FILE="$SHIELDS_DIR"/analytics-https.json
forever start -a \
  -l "$SHIELDS_DIR"/log/https-forever.log \
  -o "$SHIELDS_DIR"/log/https-out.log \
  -e "$SHIELDS_DIR"/log/https-err.log \
  --minUptime 1000 --spinSleepTime 1000 \
  server.js
popd
