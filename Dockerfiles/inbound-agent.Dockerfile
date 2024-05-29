ARG IMAGE_TYPE
ARG IMAGE_TAG
ARG CONTAINER_NAME
ARG WORKDIR="/home/jenkins/agent"
ARG HOSTDIR

FROM jenkins/${IMAGE_TYPE}:${IMAGE_TAG} as jenkins-inbound-agent

USER root

RUN adduser -u 1001 -D -h "${WORKDIR}" appuser

RUN mkdir -p "${WORKDIR}" && chown -R appuser:appuser "${WORKDIR}"

USER appuser

WORKDIR ${WORKDIR}

HEALTHCHECK NONE
