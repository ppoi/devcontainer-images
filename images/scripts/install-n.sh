#!/bin/bash

set -e

NODE_VERSION=${1:-"lts"}
echo "install node ${NODE_VERSION} with n"
curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s $NODE_VERSION
npm install -g npm n
echo "Done!"