#!/bin/bash

set -eoux pipefail

CODEOSS_PATH="/home/user/.codeoss-cloudworkstations"
SETTINGS_PATH="$CODEOSS_PATH/data/Machine"


mkdir -p $SETTINGS_PATH
cat << EOF > $SETTINGS_PATH/settings.json
{
    "workbench.colorTheme": "Default Dark+",
    "editor.tabSize": 2,
    "editor.wordWrap": "on"
}
EOF

chown -R user:user $CODEOSS_PATH
chmod -R 755 $CODEOSS_PATH