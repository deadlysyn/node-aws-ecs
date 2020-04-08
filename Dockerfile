# For production, you might lock this at a version like node:12-alpine
FROM node:lts-alpine

LABEL maintainer="mrh@devopsdreams.io"
LABEL environment="development"
LABEL description="simple hello world web service"

# Dependencies
RUN apk update && \
      apk upgrade && \
      apk --no-cache add curl

WORKDIR /app

# Ensure we get package-lock.json
COPY package*.json ./

# https://blog.npmjs.org/post/171556855892/introducing-npm-ci-for-faster-more-reliable
RUN npm ci --only=production

COPY --chown=node:node src ./src

# Run as non-root user provided by Alpine
USER node

# Use non-privileged port if not running as root
EXPOSE 8080

# Optimized for small instances
CMD [ "node", "--max-old-space-size=128", "./src/server.js" ]

