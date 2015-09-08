#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")
export HTTPS=true
export SHIELDS_ANALYTICS_FILE="$DIR"/analytics-https.json
node "$DIR"/server.js
