FROM node:12-alpine
EXPOSE 8888

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
ARG NPM_REGISTRY
RUN npm config set @gros:registry $NPM_REGISTRY
COPY package.json /usr/src/app/
COPY lib/ /usr/src/app/lib/
RUN npm install && npm cache clean --force

CMD ["npm", "start"]
