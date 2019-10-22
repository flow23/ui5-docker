FROM node:alpine
RUN apk add --no-cache bash wget unzip

ENV APP_DIR=/usr/src/app
ARG SAPUI5_VERSION
ARG SAPUI5_COMPONENT
#ENV SAPUI5_VERSION $SAPUI5_VERSION
ARG SAPUI5_ZIP=sapui5-${SAPUI5_COMPONENT}-${SAPUI5_VERSION}.zip
WORKDIR ${APP_DIR}
RUN mkdir -p webapp

# Install UI5 tooling
RUN npm config set @sap:registry "https://npm.sap.com" -g
RUN npm install --global @ui5/cli

# SAP UI5 downloading
RUN wget -nv --output-document=/tmp/${SAPUI5_ZIP} \
    #--no-cookies \
    --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
    https://tools.hana.ondemand.com/additional/${SAPUI5_ZIP} \
    && cd webapp \
    && unzip -q /tmp/${SAPUI5_ZIP} \
    && rm /tmp/${SAPUI5_ZIP} \
    && cd ${APP_DIR}

# Exposing port 8080
EXPOSE 8080

# docker-entrypoint
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]