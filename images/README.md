# DevContainer base images

## devenv-base
- based on docker.io/debian:bullseye-20240424
- common development tools
  - curl, openssl, zip, unzip, iproute2, etc..
  - Docker CLI for Docker outside of Docker
  - AWS CLI
- non-root user dedicated for vscode.

## Images
| Name | Description |
| --- | --- |
| Type-ALPHA | DevContainer for Node.js |
| Type-Bravo | DevContainer for Java |
| Type-Charile | DevContainer for Node.js & Java |

## Build ARGs
| ARG | DESCRIPTION | DEFAULT | Images |
| --- | --- | --- | --- |
| NODE_VERSION | installed Node.js version | lts | ALPHA, CHARLIE |
| JAVA_VERSION | installed MS OpenJDK Version | 21 | BRAVO, CHARLIE |
| MAVEN_VERSION | installed Apache Maven version | 3.9.6 | BRAVO, CHARLIE |
| APT_PACKAGES | additional apt packge names | (empty) | All |