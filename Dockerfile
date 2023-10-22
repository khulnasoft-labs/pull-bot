FROM node:21-alpine

LABEL \
  org.opencontainers.image.title="pull" \
  org.opencontainers.image.description="Keep your forks up-to-date via automated PRs" \
  org.opencontainers.image.url="https://github.com/khulnasoft-labs/pull-bot" \
  org.opencontainers.image.documentation="https://github.com/khulnasoft-labs/pull-bot#readme" \
  org.opencontainers.image.source="https://github.com/khulnasoft-labs/pull-bot" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.authors="Md Sulaiman <docker@khulnasoft.com>" \
  maintainer="Md Sulaiman <docker@khulnasoft.com>"

ENV \
  ####################
  ###   Required   ###
  ####################
  APP_ID= \
  WEBHOOK_SECRET= \
  PRIVATE_KEY= \
  ####################
  ###   Optional   ###
  ####################
  #CLIENT_ID= \
  #CLIENT_SECRET= \
  #SENTRY_DSN= \
  #SYSLOG_UDP_HOST= \
  #SYSLOG_UDP_PORT= \
  #GHE_HOST= \
  #IGNORED_ACCOUNTS= \
  NODE_ENV=production \
  PORT=3000 \
  LOG_FORMAT=short \
  LOG_LEVEL=info \
  WEBHOOK_PATH=/webhook \
  PULL_INTERVAL=3600 \
  JOB_TIMEOUT=60 \
  MAX_CONCURRENT=10 \
  MAX_IN_QUEUE=1000 \
  CONFIG_FILENAME=pull.yml \
  DEFAULT_MERGE_METHOD=hardreset \
  DISABLE_DELAY= \
  DISABLE_STATS= \
  _=

WORKDIR /app
COPY package*.json ./
RUN \
  npm ci --production && \
  :

COPY . .

EXPOSE 3000
CMD ["npm", "start"]

ARG VCS_REF
ARG BUILD_DATE
LABEL \
	org.opencontainers.image.ref.name=$VCS_REF \
  org.opencontainers.image.created=$BUILD_DATE
