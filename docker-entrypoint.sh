#!/bin/bash

#set -euo pipefail

# UI5 tooling check
echo "0 # UI5 project #"
cd "${APP_DIR}"

if [ ! -f "${APP_DIR}/package.json" ]; then
  echo "0 ## Generating package.json ##"
  npm init --yes
fi

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
npm install -g grunt-cli 
npm install grunt --save-dev
npm install grunt-string-replace --save-dev
npm install @openui5/sap.ui.core @openui5/themelib_sap_belize
echo "2 ## Audit fix ##"
npm audit fix

# Grunt
echo "3 # Grunt #"
grunt --gruntfile Gruntfile_fw.js -d string-replace

# Start node server
echo "4 # Serve the app #"
exec ui5 serve --accept-remote-connections