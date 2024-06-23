# Our DevContainers Pre-build Images

## base image
- based on docker.io/debian:bullseye-20240612-slim
- common development tools
  - curl, openssl, zip, unzip, iproute2, etc..
  - Docker CLI for Docker outside of Docker
  - AWS CLI
- non-root user dedicated for vscode.

## DevContainers Images
| Type | Repo  | Description |
| --- | --- | --- |
| ALPHA | devcotainer-images/type-alpha | DevContainer for Node.js |
| BRAVO | devcotainer-images/type-bravo | DevContainer for Java |
| CHARLIE | devcontainer-images/type-charlie | DevContainer for Node.js & Java |

## Build ARGs
| ARG | DESCRIPTION | DEFAULT | Images |
| --- | --- | --- | --- |
| NODE_VERSION | installed Node.js version | lts | ALPHA, CHARLIE |
| JAVA_VERSION | installed MS OpenJDK Version | 21 | BRAVO, CHARLIE |
| MAVEN_VERSION | installed Apache Maven version | 3.9.7 | BRAVO, CHARLIE |
| APT_PACKAGES | additional apt packge names | (empty) | All |