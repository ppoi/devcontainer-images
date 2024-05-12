#!/bin/bash

set -e

if [ -z "${*}" ]; then
  echo "no packags to be installed."
  exit
fi

echo "install packages: ${*}"
apt-get -y update
apt-get -y install ${*}
apt-get -y upgrade --no-install-recommends
apt-get autoremove -y
rm -rf /var/lib/apt-lists/*
echo "Done!"