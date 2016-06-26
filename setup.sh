#!/bin/bash
# We need git, node, npm, systemd

# Set up the git repository and the live directory.
DIR=$(dirname "${BASH_SOURCE[0]}")
SHIELDS_DIR="$DIR/shields"
SHIELDS_REPO_DIR="$DIR/$SHIELDS_DIR.git"
git clone --bare "https://github.com/badges/shields.git" "$SHIELDS_REPO_DIR"
cp post-receive "$SHIELDS_REPO_DIR/hooks/post-receive"
chmod +x "$SHIELDS_REPO_DIR/hooks/post-receive"
# I could not run a checkout of the bare repo on a different thing.
# We have to push a new commit from our workstation.
#GIT_WORK_TREE="$SHIELDS_DIR" git checkout -f master
mkdir "$SHIELDS_DIR"

# Set up the systemd services.
sudo cp "$DIR"/shields.service /etc/systemd/system/
sudo cp "$DIR"/shields-redirect.service /etc/systemd/system/
sudo systemctl daemon-reload

# Start the server for the first time.
# (Note: see above; it will happen when pushing a new commit.)
pushd "$SHIELDS_DIR"
#npm install
mkdir -p log
popd

sudo systemctl restart shields.service shields-redirect.service
