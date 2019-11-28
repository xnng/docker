FROM node:lts-alpine AS node

WORKDIR /app

COPY ./package.json ./

RUN yarn config set registry https://registry.npm.taobao.org/ \
    && yarn config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/ \
    && yarn

COPY ./ ./

RUN yarn test:unit

RUN yarn build

FROM nginx:alpine

ENV TZ Asia/Shanghai

COPY ./ci/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=node /app/dist /usr/share/nginx/html/