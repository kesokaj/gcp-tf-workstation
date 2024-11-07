#!/bin/bash

set -eoux pipefail

runuser -l user -c "/opt/code-oss/bin/codeoss-cloudworkstations --install-extension golang.go --force \
    --install-extension googlecloudtools.cloudcode --force \
    --install-extension hashicorp.terraform --force \
    --install-extension ms-azuretools.vscode-docker --force \
    --install-extension ms-kubernetes-tools.vscode-kubernetes-tools --force \
    --install-extension ms-python.debugpy --force \
    --install-extension ms-python.python --force \
    --install-extension redhat.vscode-yaml --force"
