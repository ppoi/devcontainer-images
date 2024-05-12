#!/bin/bash
PROJECT_NAME=${1:-devenv}
WORKSPACE_SPEC="/workspaces/${PROJECT_NAME}.code-workspace"
if [ ! -f ${WORKSPACE_SPEC} ]; then
  tee ${WORKSPACE_SPEC} <<EOF
{
  "folders": [
    {
      "name": "devenv",
      "path": "/workspaces/devenv"
    }
  ]
}
EOF
fi
tail -f /dev/null
