#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")
HTTPS=true node "$DIR"/server.js
