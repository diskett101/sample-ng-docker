FROM node:lts-alpine AS build

USER root

WORKDIR /app

RUN npm install -g @angular/cli

COPY ./test-app/package.json /app

RUN npm install

COPY ./test-app/. /app/

RUN npm run build

FROM httpd:alpine AS serve

COPY --from=build /app/dist/. /usr/local/apache2/htdocs/

RUN ls -las /usr/local/apache2/htdocs/


