#!/bin/bash

# Configuration Sharing
shareConfig() {
    if [ -L ~/${1} ]; then
        return
    fi
    if [ ! -d /workspaces/${1} ]; then
        sudoIf mkdir -p /workspaces/${1}
        sudoIf chown $(id -u):$(id -g) /workspaces/${1}
    fi
    ln -s /workspaces/${1} ~/${1}
}
shareConfig .m2