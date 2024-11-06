#!/bin/bash

set -eoux pipefail

runuser -l user -c code-oss-cloud-workstations --install-extension golang.go --force &&
    code-oss-cloud-workstations --install-extension googlecloudtools.cloudcode --force &&
    code-oss-cloud-workstations --install-extension hashicorp.terraform --force &&
    code-oss-cloud-workstations --install-extension ms-azuretools.vscode-docker --force &&
    code-oss-cloud-workstations --install-extension ms-kubernetes-tools.vscode-kubernetes-tools --force &&
    code-oss-cloud-workstations --install-extension ms-python.debugpy --force &&
    code-oss-cloud-workstations --install-extension ms-python.python --force &&
    code-oss-cloud-workstations --install-extension ms-python.vscode-pylance --force && 
    code-oss-cloud-workstations --install-extension redhat.vscode-yaml --force
