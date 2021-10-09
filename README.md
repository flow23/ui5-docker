# ui5-docker
UI5 development environment in a docker container.
It uses node.js and the UI5 tooling to serve the app.

## Build docker container
docker build --build-arg SAPUI5_VERSION=1.84.18 --build-arg SAPUI5_COMPONENT=rt -f Dockerfile -t ui5-docker:1.84.18-rt .

*You have to provide two build args, the SAP UI5 Version and the SAP UI5 Component (RT/SDK). Please use this link for reference https://tools.hana.ondemand.com/#sapui5*

## Run docker container
docker run -d -p 8080:8080 -v $(pwd)/app:/usr/src/app ui5-docker:1.84.18-rt

## Jump into container
docker exec -it ${containerid} /bin/bash

## Useful links
* [UI5 tooling](https://github.com/SAP/ui5-tooling)
