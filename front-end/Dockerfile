FROM node:10-slim AS node

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn --registry=https://registry.npm.taobao.org

COPY . ./

RUN yarn build

FROM nginx:latest

COPY --from=node /app/dist /home/html/

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
