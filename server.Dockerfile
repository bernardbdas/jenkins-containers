ARG JENKINS_SERVER_IMAGE_TYPE
ARG JENKINS_SERVER_IMAGE_TAG
FROM jenkins/${JENKINS_SERVER_IMAGE_TYPE}:${JENKINS_SERVER_IMAGE_TAG}
USER root
COPY --chown=jenkins:jenkins executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy