#build phase
FROM node:alpine3.21 AS build
WORKDIR  /app

COPY package*.json .
RUN npm ci

COPY tsconfig.json tsconfig.json
COPY src/* src/
COPY public/*  public/

RUN npm run build



#serve phase
FROM nginx:1.27.0
COPY --from=build /app/build  /usr/share/nginx/html