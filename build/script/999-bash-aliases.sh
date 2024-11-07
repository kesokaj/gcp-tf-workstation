#!/bin/bash

set -eoux pipefail

ALIASES="/home/user/.bash_aliases"

cat << EOF > $ALIASES
alias tf='terraform'
alias k='kubectl'
alias code='code-oss-cloud-workstations'
EOF


chown user:user $ALIASES
chown 755 $ALIASES

runuser -l user -c "echo 'source <(kubectl completion bash)' >>~/.bashrc"
runuser -l user -c "echo 'complete -o default -F __start_kubectl k' >>~/.bashrc"
runuser -l user -c "source ~/.bashrc"