# openui5-ide-docker
OpenUI5 development environment in a docker container.
It uses node.js and the UI5 tooling to serve the app.

## Run docker container
docker run -p 8080:8080 -v \$(pwd)\app:/usr/src/app -d openui5-ide-docker

## Useful links
* [UI5 tooling](https://github.com/SAP/ui5-tooling)
