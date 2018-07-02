FROM node:8.11.1-slim

WORKDIR /app

COPY . ${WORKDIR}

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org \
    && cnpm install \
    && npm run build \
    && cnpm install -g serve

WORKDIR /app/dist

EXPOSE 5000

ENTRYPOINT [ "serve", "-s" ]