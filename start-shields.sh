#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SHIELDS_DIR="$DIR/shields"
cd "$SHIELDS_DIR"
export SHIELDS_ANALYTICS_FILE="$SHIELDS_DIR"/analytics-https.json
export NODE_CONFIG_ENV=shields-io-production
node --max_old_space_size=1380 ./server.js >> log/out 2>&1
