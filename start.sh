#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")
SHIELDS_DIR="$DIR/shields"
pushd "$SHIELDS_DIR"
forever start -a -l log/forever.log -o log/out.log -e log/err.log server.js
forever start -a -l log/https-forever.log -o log/https-out.log -e log/https-err.log -c bash https-server.sh
popd
