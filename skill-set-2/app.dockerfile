FROM node:10-alpine

ENV PORT=7123

RUN npm install ip

RUN mkdir /app

COPY app.js /app

WORKDIR /app

CMD [ "node", "app.js" ]