#!/bin/bash
echo "install AWS CLI"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
pushd /tmp
unzip awscliv2.zip
./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
popd
rm -rf /tmp/awscliv2.zip /tmp/aws/ /var/lib/apt-lists/*
echo "Done!"