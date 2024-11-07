#!/bin/bash

set -eoux pipefail

runuser -l user -c "curl -sS https://webi.sh/k9s | sh"
runuser -l user -c "source ~/.config/envman/PATH.env"