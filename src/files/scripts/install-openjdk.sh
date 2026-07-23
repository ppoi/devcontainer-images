#!/bin/bash

set -e

JAVA_VERSION=${1:-"21"}
APT_PACKAGES=${@:2}

echo "Install Eclipse Temurin OpenJDK & additional tools"
echo "    JAVA_VERSION: ${JAVA_VERSION}"
echo "    Additional Packages: ${@:2}"
curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /usr/share/keyrings/adoptium.gpg > /dev/null \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(. /etc/os-release && echo "$VERSION_CODENAME") main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo /opt/setup-tools/install-apt-packages.sh temurin-${JAVA_VERSION}-jdk ${APT_PACKAGES}
echo "Done!"