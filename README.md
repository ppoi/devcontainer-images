# Our DevContainers Pre-build Images

## base image spec
- based on `docker.io/debian:bookworm-20240701-slim`
- common development tools
  - curl, openssl, zip, unzip, iproute2, etc..
  - Docker CLI for Docker outside of Docker
  - AWS CLI
  - Custom Setup Scripts
- non-root user dedicated for vscode(uid=1001).

## DevContainers Images
| Type | Repo  | Description |
| --- | --- | --- |
| ALPHA | devcotainer-images/type-alpha | DevContainer for Node.js |
| BRAVO | devcotainer-images/type-bravo | DevContainer for Java(Microsoft OpenJDK) |
| CHARLIE | devcontainer-images/type-charlie | DevContainer for Node.js & Java |
| DELTA | devcontainer-images/type-delta | DevContainer for Python3(debian bundled) |

## Build ARGs
| ARG | DESCRIPTION | DEFAULT | Images |
| --- | --- | --- | --- |
| NODE_VERSION | installed Node.js version | lts | ALPHA, CHARLIE |
| JAVA_VERSION | installed MS OpenJDK Version | 21 | BRAVO, CHARLIE |
| MAVEN_VERSION | installed Apache Maven version | 3.9.8 | BRAVO, CHARLIE |
| APT_PACKAGES | additional apt packge names | (empty) | All |

## Custom Setup Scripts
Any scripts in `/opt/setup-tools`
| NAME | USAGE | DESCRIPTION |
| --- | --- | --- |
| apt-packages | `install-apt-package [<PACKAGE> ...]` | Install & update apt packages. |
| awscli | `install-awscli.sh` | Install Latest AWS CLI |
| ca | `install-ca.sh <CAName> <SRC>` | Install CA cert to Container, Java default keystore. `SRC` is certification URL or absolute file path |
| deb | `install-deb.sh <deb URL>` | Install deb package from URL |
| maven | `install-maven.sh [<MAVEN_VERSION>]` | Install Maven(default:3.9.8). |
| msopenjdk | `install-msopenjdk.sh <JAVA_VERSION> [<other package> ...]` | Install Microsoft OpenJDk(default:21) |
| n | `install-n.sh <NODE_VERSION>` | Install n(node version manager. default LTS) |