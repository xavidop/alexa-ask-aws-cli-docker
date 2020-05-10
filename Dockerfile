# Original source from https://hub.docker.com/_/node/
FROM node:lts-alpine
LABEL maintainer="Xavier Portilla Edo <xavierportillaedo@gmail.com>"
ARG ASK_CLI_VERSION=2.1.1

ENV CLI_VERSION @${ASK_CLI_VERSION}

# NPM_CONFIG_PREFIX: See below
# PATH: Required for ask cli location
ENV TZ="GMT" \
  NPM_CONFIG_PREFIX=/home/node/.npm-global \
  PATH="${PATH}:/home/node/.npm-global/bin/:/home/node/.local/bin/"

# Required pre-reqs for ask cli
RUN apk add --update \
  jq \
  expect \
  python \
  make \
  bash \
  zip \
  git \
  py-pip

# See https://github.com/nodejs/docker-node/issues/603
# ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
WORKDIR /app
USER node

# /home/node/.ask: For ask CLI configuration file
# /home/node/.ask: Folder to map to for app development
RUN npm install -g ask-cli${CLI_VERSION}  bespoken-tools && \
  mkdir /home/node/.ask && \
  mkdir /home/node/.aws && \
  mkdir /home/node/app && \
  mkdir /home/node/.bst && \
  pip install awscli --upgrade --user

# Patch for  https://github.com/martindsouza/docker-amazon-ask-cli/issues/1
WORKDIR /$NPM_CONFIG_PREFIX/lib/node_modules/ask-cli
RUN npm install simple-oauth2@1.5.0 --save-exact

# Default folder for developers to work in
WORKDIR /home/node/app
