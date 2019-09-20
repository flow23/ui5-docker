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
npm install @openui5/sap.ui.core @openui5/themelib_sap_belize
echo "2 ## Audit fix ##"
npm audit fix

# Symlinking and downloading
echo "3 # Downloading SAP UI5 runtime #"
# -nv no verbose, -v verbose
wget -v --output-document=/tmp/sapui5-rt-${SAPUI5_VERSION}.zip \
--no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
https://tools.hana.ondemand.com/additional/sapui5-rt-${SAPUI5_VERSION}.zip
mkdir -p ${APP_DIR}/webapp/resources
unzip /tmp/sapui5-rt-${SAPUI5_VERSION}.zip -d ${APP_DIR}/webapp

# Cleanup
apk del wget unzip

# Start node server
echo "4 # Serve the app #"
exec ui5 serve --accept-remote-connections --open test/flpSandboxMockServer.html