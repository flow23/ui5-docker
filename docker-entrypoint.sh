#!/bin/bash

set -euo pipefail

# UI5 tooling check
echo "0 # UI5 project #"
cd "${APP_DIR}"
# RUN npm init --yes
if [ ! -f "${APP_DIR}/ui5.yaml" ]; then
  echo "0 ## Initializing ui5 project ##"
  ui5 init
fi

# Install node.js project dependencies from package.json
echo "1 # NPM #"
echo "1 ## Install ##"
npm install
echo "1 ## Audit fix ##"
npm audit fix

# UI5 specific stuff
echo "2 # SAP #"
npm install grunt-string-replace
npm install @openui5/sap.ui.core @openui5/themelib_sap_belize

# Start node server
echo "3 # Serve the app #"
exec ui5 serve --accept-remote-connections
