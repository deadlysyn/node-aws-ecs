FROM node:lts-alpine
LABEL maintainer="mrh@devopsdreams.io"

# Dependencies
RUN apk update && \
      apk upgrade && \
      apk --no-cache add curl

WORKDIR /app

# Ensure we get package-lock.json
COPY --chown=node:node package*.json ./

# Run as non-root user provided by Alpine
USER node

# https://blog.npmjs.org/post/171556855892/introducing-npm-ci-for-faster-more-reliable
RUN npm ci --only=production

COPY --chown=node:node src ./src

EXPOSE 8080

# For small instances, set --max_old_space_size to 4/5ths
# of available memory.
CMD [ "node", "--max-old-space-size=256", "./src/server.js" ]

