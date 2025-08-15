#!/bin/bash
MAVEN_VERSION=${1:-"3.9.11"}
VERSION=(${MAVEN_VERSION//./ })
echo "install maven ${MAVEN_VERSION}"
curl -fsSL https://dlcdn.apache.org/maven/maven-${VERSION[0]}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar xz -C /opt/
if [ -h "/usr/local/bin/mvn" ]; then
  unlink "/usr/local/bin/mvn"
fi
ln -s /opt/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/local/bin/mvn
echo "Done!"