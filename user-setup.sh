# This file is not meant to be run.
exit 0

# First, login as root. Change the password to something very secure.
passwd

# Then, create the secondary user.
useradd --create-home --user-group --key UMASK=022 m
passwd m

# Add necessary packages.
apt-get update
apt-get install build-essential git libssl-dev phantomjs libjpeg-turbo8-dev libcairo2-dev
# Installing phantomjs on debian will be a pain. sorry.

# We will now build the latest node. As a safeguard (for an accidental rm in the
# make script), we will log in as m.
mkdir node-js && cd node-js && wget -Nq "http://nodejs.org/dist/node-latest.tar.gz" && tar xzf node-latest.tar.gz && cd node-v* && ./configure && make
# Then, as root:
make install && cd ../.. && rm -rf node-js

# For convenience, we will allow git to push.
echo 'command="git-shell",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAbase64' >> ~/.ssh/authorized_keys

# Now, we can download shields.
git clone https://github.com/badges/ServerScript.git
cp ServerScript/* .

# Finally, as m:
./setup.sh

# We also need certificates, so, as root:
cd shields/node_modules/camp
make https  # Answer the few questions
cp https.crt ../..
cp https.csr ../..
cp https.key ../..
cd ../..
