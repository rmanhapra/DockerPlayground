#build phase
FROM node:alpine3.21 AS build
WORKDIR  /app

COPY package*.json .
RUN npm ci

COPY tsconfig.json tsconfig.json
COPY src/* src/
COPY public/*  public/

CMD ["npm","start"]
