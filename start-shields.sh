#!/bin/bash

cd /home/m/shields/
export HTTPS=true
export SHIELDS_ANALYTICS_FILE="$SHIELDS_DIR"/analytics-https.json
node ./server.js >> log/out 2>&1
