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
echo "3 # Symlinking #"
#mkdir -p webapp/resources/sap/ushell/services
#ln -s /usr/src/app/node_modules/@openui5/sap.ui.core/src/sap-ui-core.js webapp/resources/sap-ui-core.js
#wget -O webapp/resources/sandbox.js "https://sapui5.hana.ondemand.com/test-resources/sap/ushell/bootstrap/sandbox.js"
#wget -O webapp/resources/sap/ushell/services/Container.js "https://sapui5.hana.ondemand.com/resources/sap/ushell/services/Container.js"
#wget -O webapp/resources/sap/ushell/utils.js "https://sapui5.hana.ondemand.com/resources/sap/ushell/utils.js"
#wget -O webapp/resources/sap/ushell/utils/clone.js "https://sapui5.hana.ondemand.com/resources/sap/ushell/utils/clone.js"

# Start node server
echo "4 # Serve the app #"
exec ui5 serve --accept-remote-connections --open test/flpSandboxMockServer.html