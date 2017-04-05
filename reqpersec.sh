#!/bin/bash
DIR=$(dirname "${BASH_SOURCE[0]}")
(
  echo "-"
  node "$DIR"/stats.js
  sleep 1
  echo "+"
  node "$DIR"/stats.js
) | (tr "\n" " "; echo) | bc
