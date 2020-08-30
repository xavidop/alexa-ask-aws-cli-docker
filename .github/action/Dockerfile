# Original source from https://hub.docker.com/repository/docker/xavidop/alexa-ask-aws-cli
FROM xavidop/alexa-ask-aws-cli:latest
LABEL maintainer="Xavier Portilla Edo <xavierportillaedo@gmail.com>"

ADD --chown=node:node entrypoint.sh ./entrypoint.sh

RUN chmod +X ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]