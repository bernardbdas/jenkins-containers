ARG IMAGE_TYPE
ARG IMAGE_TAG
ARG CONTAINER_NAME
ARG HOSTDIR
ARG PATH_TO_EXECS="../config/executors.groovy"

FROM jenkins/${IMAGE_TYPE}:${IMAGE_TAG} as jenkins-server

ENV WORKDIR="/var/jenkins_home"

USER root

RUN sh -c jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

RUN echo $JENKINS_VERSION > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

RUN echo $JENKINS_VERSION > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

RUN adduser -u 1001 -D -h ${WORKDIR} appuser

WORKDIR ${WORKDIR}

RUN chown -R appuser:appuser ${WORKDIR}

USER appuser

WORKDIR ${WORKDIR}

HEALTHCHECK NONE