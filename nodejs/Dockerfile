FROM keymetrics/pm2:10-alpine

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn --registry=https://registry.npm.taobao.org

COPY . ./

CMD [ "pm2-runtime", "start", "pm2.json" ]