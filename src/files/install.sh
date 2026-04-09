#!/bin/bash

BASEDIR=$(cd $(dirname $0);pwd)

## APT initialize
echo "# Initalize apt-get environment"
echo "----------------------------------------"
apt-get update -y
apt-distupgrade -y --no-install-recommends
echo "Done!"
echo "----------------------------------------"

## Basical packages
echo "# Install basicak packages"
echo "----------------------------------------"
apt-get install -y --no-install-recommends sudo curl ca-certificates locales-all git zip unzip gpg openssl iproute2 iputils-ping net-tools procps socat
echo "Done!"
echo "----------------------------------------"

## Install Docker CLI
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor > /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list
apt-get update -y
apt-get install -y --no-install-recommends docker-ce-cli docker-buildx-plugin docker-compose-plugin
groupadd --system docker
echo "Done!"
echo "----------------------------------------"

echo "# install AWS CLI"
echo "----------------------------------------"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
pushd /tmp
unzip awscliv2.zip
./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
popd

DEB_FILE="/tmp/session-manager-plugin.deb"
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "${DEB_FILE}"
dpkg -i "${DEB_FILE}"

rm -rf /tmp/awscliv2.zip /tmp/aws/ ${DEB_FILE}

echo "Done!"
echo "----------------------------------------"

## Developer environment
echo "# Install basicak packages"
echo "----------------------------------------"
useradd --uid 1000 --create-home --shell /bin/bash vscode && usermod -aG docker vscode && echo "vscode ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/vscode
tee -a /home/vscode/.bashrc <<"EOF"
# bash theme - partly inspired by https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme
__bash_prompt() {
    local userpart='`export XIT=$? \
        && [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[0;32m\]@${GITHUB_USER} " || echo -n "\[\033[0;32m\]\u " \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
    local gitbranch='`\
        if [ "$(git config --get devcontainers-theme.hide-status 2>/dev/null)" != 1 ] && [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then \
            export BRANCH=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null); \
            if [ "${BRANCH}" != "" ]; then \
                echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
                && if [ "$(git config --get devcontainers-theme.show-dirty 2>/dev/null)" = 1 ] && \
                    git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                        echo -n " \[\033[1;33m\]✗"; \
                fi \
                && echo -n "\[\033[0;36m\]) "; \
            fi; \
        fi`'
    local lightblue='\[\033[1;34m\]'
    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${lightblue}\w ${gitbranch}${removecolor}\$ "
    unset -f __bash_prompt
}
__bash_prompt
export PROMPT_DIRTRIM=4
EOF
echo "Done!"
echo "----------------------------------------"

# Scripts
echo "# Install scripts"
echo "----------------------------------------"
cp -r ${BASEDIR}/scripts /opt/setup-tools
chown -R root:root /opt/setup-tools
chmod 755 /opt/setup-tools/*.sh

cp ${BASEDIR}/entrypoint.sh /usr/local/share/
chmod 755 /usr/local/share/entrypoint.sh

mkdir /usr/local/share/entrypoint.d

cp ${BASEDIR}/NOTIC /etc/NOTICE-devcontainer-images-base
echo "Done!"
echo "----------------------------------------"

# Cleanup
echo "# Cleanup"
echo "----------------------------------------"
apt-get clean
rm -rf /var/lib/apt/lists/*
echo "Done!"
echo "----------------------------------------"
