#!/bin/bash

if [ ! -d /workspaces/.pnpm-store ]; then
  sudoIf mkdir /workspaces/.pnpm-store
  sudoIf chown $(id -u):$(id -g) /workspaces/.pnpm-store
fi
PNPM=$(which pnpm || ls ~/.local/share/pnpm/pnpm 2>/dev/null || ls ~/.local/share/pnpm/bin/pnpm 2>/dev/null || true)
if [ -z "${PNPM}" ]; then
  echo "pnpm may not be installed. skip configure store-dir"
else
  ${PNPM} config set store-dir /workspaces/.pnpm-store
fi
