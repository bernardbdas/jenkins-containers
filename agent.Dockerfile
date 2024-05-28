ARG JENKINS_AGENT_IMAGE_TYPE
ARG JENKINS_AGENT_IMAGE_TAG
ARG JENKINS_AGENT_SSH_PUBKEY
ARG JENKINS_BASE_REPO
FROM jenkins/${JENKINS_AGENT_IMAGE_TYPE}:${JENKINS_AGENT_IMAGE_TAG} as ssh-agent
USER root
COPY --chown=jenkins "${JENKINS_AGENT_SSH_PUBKEY}" "${JENKINS_BASE_REPO}"/.ssh/jenkins_agent.pub

# Install Docker (example for Alpine Linux)
RUN apk update && apk add docker openrc
RUN rc-update add docker boot 
RUN touch /run/openrc/softlevel
RUN service docker start

# Copy the SSH public key
RUN mkdir -p /root/.ssh 
RUN echo "${JENKINS_AGENT_SSH_PUBKEY}" >> /root/.ssh/authorized_keys 
RUN chmod 600 /root/.ssh/authorized_keys
USER 1001