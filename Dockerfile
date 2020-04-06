FROM node:lts-alpine
LABEL maintainer="mrh@devopsdreams.io"

# Dependencies
RUN apk update && \
      apk upgrade && \
      apk --no-cache add curl

ENV NODE_ENV production
WORKDIR /app

# Ensure we get package-lock.json and take advantage of cache
COPY package*.json ./

# https://blog.npmjs.org/post/171556855892/introducing-npm-ci-for-faster-more-reliable
RUN npm ci --only=production

COPY --chown=999:999 src ./src

USER node

EXPOSE 8080
CMD [ "node", "./src/server.js" ]

