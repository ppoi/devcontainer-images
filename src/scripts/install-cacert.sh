#!/bin/bash

set -e

#####################################################################
## USAGE: install-cacert.sh <{alias}:{cert_src}> (<{alias}:{cert_src}>)..
#####################################################################

function install-ca() {
  # CA_SRC: <alias>:<cert_src>
  CANAME=$(echo "$1" | sed -e 's/^\([^:]\+\):\(.*\)$/\1/' 2>/dev/null)
  CERT_SRC=$(echo "$1" | sed -e 's/^\([^:]\+\):\(.*\)$/\2/' 2>/dev/null)
  echo "CA alias: ${CANAME}"
  echo "CA source: ${CERT_SRC}"
  if [ -z "${CANAME}" ]; then
    echo "Missing CA alias."
    exit 1
  elif [ -z "${CERT_SRC}" ]; then
    echo "Missing CA cert source."
    exit 1
  fi

  CERT_DATA=""
  if echo "${CERT_SRC}" | grep -E '^http(s)?://.*$' > /dev/null; then
    echo "cert from URL"
    if which curl; then
      echo "curl ready."
    else
      echo "install curl"
      sudo /opt/install-apt-packages.sh curl
    fi
    CERT_DATA=$(curl -kL "$1")
  elif [ -f "${CERT_SRC}" ]; then
    echo "cert from file: ${CERT_SRC}"
    CERT_DATA=$(cat "${CERT_SRC}")
  fi

  if [ -z "${CERT_DATA}" ]; then
    echo "Missing CA cert contents."
    exit 1
  fi

  echo "install CA cert: ${CANAME}"
  echo "${CERT_DATA}" | sudo tee "/usr/local/share/ca-certificates/${CANAME}.crt"
  sudo update-ca-certificates

  if which keytool > /dev/null; then
    echo "install CA cert into JVM default keystore."
    sudo keytool -importcert -cacerts -alias ${CANAME} -storepass "${JVM_KEYSTORE_PASS:-"changeit"}" -trustcacerts -no-prompt -file "/usr/local/share/ca-certificates/${CANAME}.crt"
  fi
}

for CA in $@; do
  install-ca "${CA}"
done
