FROM node:alpine
RUN apk add --no-cache git bash

WORKDIR /usr/src/app
# COPY webapp/ .
RUN git clone https://github.com/SAP/openui5-sample-app.git
WORKDIR openui5-sample-app
# Install node.js project dependencies from package.json
RUN npm install

# Install UI5 tooling
RUN npm install --global @ui5/cli

# Verify installation
#RUN ui5 --help

# Serve the app
EXPOSE 8080
CMD [ "ui5" , "serve", "--accept-remote-connections" ]
