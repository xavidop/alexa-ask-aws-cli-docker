# Original source from https://hub.docker.com/repository/docker/xavidop/alexa-ask-aws-cli
FROM xavidop/alexa-ask-aws-cli:latest
LABEL maintainer="Xavier Portilla Edo <xavierportillaedo@gmail.com>"

ADD --chown=node:node entrypoint.sh /home/node/entrypoint.sh

RUN chmod 777 /home/node/entrypoint.sh

ENTRYPOINT ["/home/node/entrypoint.sh"]