#!/bin/bash

if [ -z "$1" ]; then
  exit
fi
echo "install deb package from $1"
FILE_NAME="/tmp/$(date +%s).deb"
curl -fsSL $1 > ${FILE_NAME}
dpkg -i ${FILE_NAME}
rm -f ${FILE_NAME}
echo "Done!"