ARG IMAGE_TYPE
ARG IMAGE_TAG
ARG CONTAINER_NAME
ARG HOSTDIR
ARG PATH_TO_EXECS="../config/executors.groovy"

FROM jenkins/${IMAGE_TYPE}:${IMAGE_TAG} as jenkins-server

ENV WORKDIR="/var/jenkins_home"

USER root

RUN adduser -u 1001 -D -h ${WORKDIR} appuser

WORKDIR ${WORKDIR}

RUN chown -R appuser:appuser .

USER appuser

WORKDIR ${WORKDIR}

HEALTHCHECK NONE