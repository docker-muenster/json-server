FROM node:6.2

ARG JSON_SERVER_VERSION=0.8.15
RUN npm install --global json-server@$JSON_SERVER_VERSION

# hack to increase size limit
RUN sed -i -e "s/{limit: '10mb'}/{limit: '100mb'}/" \
  /usr/local/lib/node_modules/json-server/src/server/router/index.js

COPY json-server.json /etc/json-server/

VOLUME /etc/json-server
VOLUME /var/lib/json-server

CMD ["json-server", "--config", "/etc/json-server/json-server.json", "/var/lib/json-server/db.json"]
EXPOSE 3000
