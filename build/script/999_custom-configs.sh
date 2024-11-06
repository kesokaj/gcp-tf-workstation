#!/bin/bash

set -eoux pipefail

CODEOSS_PATH="/home/user/.codeoss-cloudworkstations"
SETTINGS_PATH="$CODEOSS_PATH/data/Machine"
ALIASES="/home/user/.bash_aliases"

mkdir -p $SETTINGS_PATH
cat << EOF > $SETTINGS_PATH/settings.json
{
    "workbench.colorTheme": "Default Dark+",
    "editor.tabSize": 2,
    "editor.wordWrap": "on"
}
EOF

cat << EOF > $ALIASES
alias tf='terraform'
alias k='kubectl'
alias code='code-oss-cloud-workstations'
EOF


chown user:user $ALIASES
chown 755 $ALIASES
chown -R user:user $CODEOSS_PATH
chmod -R 755 $CODEOSS_PATH

runuser -l user -c "/opt/code-oss/bin/codeoss-cloudworkstations --install-extension golang.go --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension googlecloudtools.cloudcode --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension hashicorp.terraform --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension ms-azuretools.vscode-docker --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension ms-kubernetes-tools.vscode-kubernetes-tools --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension ms-python.debugpy --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension ms-python.python --force && \
    /opt/code-oss/bin/codeoss-cloudworkstations --install-extension redhat.vscode-yaml --force"

runuser -l user -c "curl -sS https://webi.sh/k9s | sh"
runuser -l user -c "source ~/.config/envman/PATH.env"