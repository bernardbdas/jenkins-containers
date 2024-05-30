ARG IMAGE_TYPE
ARG IMAGE_TAG
ARG CONTAINER_NAME

ARG HOSTDIR

FROM jenkins/${IMAGE_TYPE}:${IMAGE_TAG} as jenkins-ssh-agent

COPY --chown=jenkins mykey "${JENKINS_AGENT_HOME}"/.ssh/mykey

ENV WORKDIR="/home/jenkins/agent"

USER root

RUN jenkins-plugin-cli --plugins pipeline-model-definition github-branch-source:1.8

RUN apk add --update --no-cache docker openrc

RUN rc-update add docker boot

RUN adduser -u 1001 -D -h ${WORKDIR} appuser

WORKDIR ${WORKDIR}

RUN chown -R appuser:appuser ${WORKDIR}

USER appuser

WORKDIR ${WORKDIR}

HEALTHCHECK NONE
