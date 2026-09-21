#!/bin/bash
PROJECT_NAME=${1:-devenv}
WORKSPACE_SPEC="/workspaces/${PROJECT_NAME}.code-workspace"
if [ ! -f ${WORKSPACE_SPEC} ]; then
  sudoIf tee ${WORKSPACE_SPEC} <<EOF
{
  "folders": [
    {
      "name": "${PROJECT_NAME}",
      "path": "/workspaces/${PROJECT_NAME}"
    }
  ]
}
EOF
  sudoIf chown $(id -u):$(id -g) ${WORKSPACE_SPEC}
fi
