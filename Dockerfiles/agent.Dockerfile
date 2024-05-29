ARG IMAGE_TYPE
ARG IMAGE_TAG
ARG CONTAINER_NAME

ARG HOSTDIR

FROM jenkins/${IMAGE_TYPE}:${IMAGE_TAG} as jenkins-ssh-agent

ENV WORKDIR="/home/jenkins/agent"

USER root

RUN adduser -u 1001 -D -h ${WORKDIR} appuser

WORKDIR ${WORKDIR}

RUN chown -R appuser:appuser .

USER appuser

WORKDIR ${WORKDIR}

HEALTHCHECK NONE
