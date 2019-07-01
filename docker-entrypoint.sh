#!/bin/bash

set -euo pipefail

cd /usr/src/app
# RUN npm init --yes
ui5 init

# Install node.js project dependencies from package.json
npm install

# ???
npm install grunt-string-replace
npm install @openui5/sap.ui.core @openui5/themelib_sap_belize 

#CMD [ "ui5" , "serve", "--accept-remote-connections" ]
exec ui5 serve --accept-remote-connections