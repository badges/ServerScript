#!/bin/bash
# We need git, node, npm, forever

# Set up the git repository and the live directory.
DIR=$(dirname "${BASH_SOURCE[0]}")
SHIELDS_DIR="$DIR/shields"
SHIELDS_REPO_DIR="$DIR/$SHIELDS_DIR.git"
git clone --bare "https://github.com/badges/shields.git" "$SHIELDS_REPO_DIR"
cp post-receive "$SHIELDS_REPO_DIR/hooks/post-receive"
chmod +x "$SHIELDS_REPO_DIR/hooks/post-receive"
GIT_WORK_TREE="$SHIELDS_DIR" git checkout -f master
cp https-server.sh "$SHIELDS_DIR"

# Start the server for the first time.
pushd "$SHIELDS_DIR"
npm install
popd
./start.sh
