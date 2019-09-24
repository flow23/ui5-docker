FROM node:alpine
RUN apk add --no-cache bash wget unzip

ENV APP_DIR=/usr/src/app
ENV SAPUI5_VERSION=1.60.5
WORKDIR $APP_DIR
COPY app/ .

# Install UI5 tooling
RUN npm config set @sap:registry "https://npm.sap.com" -g
RUN npm install --global @ui5/cli

# SAP UI5 downloading
RUN wget -nv --output-document=/tmp/sapui5-rt-${SAPUI5_VERSION}.zip \
    --no-cookies --header "Cookie: eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
    https://tools.hana.ondemand.com/additional/sapui5-rt-${SAPUI5_VERSION}.zip
RUN unzip /tmp/sapui5-rt-${SAPUI5_VERSION}.zip

# Exposing port 8080
EXPOSE 8080

# docker-entrypoint
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]