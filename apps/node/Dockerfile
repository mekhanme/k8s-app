FROM node:16-alpine

WORKDIR /app

COPY ./ ./

RUN npm install -g yarn forever --force && \
  yarn install --production --force

RUN apk --update add --no-cache bitcoin-cli bash redis mysql-client

USER node

EXPOSE 3000

CMD ["forever", "app.js"]