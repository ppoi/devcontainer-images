#!/bin/bash

set -e

CA_DATA=""
if echo "$2" | grep -E '^http(s)?://.*$' > /dev/null; then
  echo "cert from URL"
  if which curl; then
    echo "curl ready."
  else
    echo "install curl"
    sudo /opt/install-apt-packages.sh curl
  fi
  CERT_DATA=$(curl -kL "$2")
elif [ -f "$2" ]; then
  echo "cert from file: $2"
  CERT_DATA=$(cat "$2")
fi

if [ -z "${CERT_DATA}" ]; then
  echo "Missing CA cert source."
  exit 1
fi

echo "install CA cert: ${1}"
echo "${CERT_DATA}" | tee "/usr/local/share/ca-certificates/${1}.crt"
sudo update-ca-certificates

if which keytool > /dev/null; then
  echo "install CA cert into JVM default keystore."
  sudo keytool -cacerts -import -alias ${CANAME} -storepass "${JVM_KEYSTORE_PASS:-"changeit"}" -f "/usr/local/share/ca-certificates/${CANAME}.crt"
fi