#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SHIELDS_DIR="$DIR/shields"
cd "$SHIELDS_DIR"
export HTTPS=true
export SHIELDS_ANALYTICS_FILE="$SHIELDS_DIR"/analytics-https.json
node ./server.js >> log/out 2>&1