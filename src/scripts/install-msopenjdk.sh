#!/bin/bash

set -e

JAVA_VERSION=${1:-"21"}
APT_PACKAGES=${@:2}

echo "Install Microsoft OpenJDK & additional tools"
echo "    JAVA_VERSION: ${JAVA_VERSION}"
echo "    Additional Packages: ${@:2}"
sudo /opt/setup-tools/install-deb.sh https://packages.microsoft.com/config/debian/$(. /etc/os-release && echo "$VERSION_ID")/packages-microsoft-prod.deb
sudo /opt/setup-tools/install-apt-packages.sh msopenjdk-${JAVA_VERSION} ${APT_PACKAGES}
echo "Done!"