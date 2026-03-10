#!/bin/bash

set -e

echo "install packages: ${*}"
apt-get -y update
if [ ! -z "${*}" ]; then
  apt-get -y install ${*}
fi
apt-get -y upgrade --no-install-recommends
apt-get autoremove -y
rm -rf /var/lib/apt-lists/*
echo "Done!"