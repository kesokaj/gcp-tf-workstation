#!/bin/bash

set -eoux pipefail

runuser -l user -c "if [ ! -f /home/user/.ssh/id_ed25519 ]; then yes | ssh-keygen -t ed25519 -C cloud-workstation-user -f /home/user/.ssh/id_ed25519; fi"