#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SHIELDS_DIR="$DIR/shields"
cd "$SHIELDS_DIR"
export HTTPS=true
export SHIELDS_ANALYTICS_FILE="$SHIELDS_DIR"/analytics-https.json
export ALLOWED_ORIGIN=http://shields.io,https://shields.io
export REDIRECT_URI=https://shields.io/
export GITHUB_DEBUG_ENABLED=false
node --max_old_space_size=1380 ./server.js >> log/out 2>&1
