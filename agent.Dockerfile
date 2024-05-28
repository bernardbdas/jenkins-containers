ARG JENKINS_AGENT_IMAGE_TYPE
ARG JENKINS_AGENT_IMAGE_TAG
ARG JENKINS_AGENT_SSH_PUBKEY
ARG JENKINS_BASE_REPO
USER root
FROM jenkins/${JENKINS_AGENT_IMAGE_TYPE}:${JENKINS_AGENT_IMAGE_TAG} as ssh-agent
COPY --chown=jenkins "${JENKINS_AGENT_SSH_PUBKEY}" "${JENKINS_BASE_REPO}"/.ssh/jenkins_agent.pub

# Install Docker (example for Alpine Linux)
RUN apk update && apk add docker openrc \
    && rc-update add docker boot \
    && service docker start

# Copy the SSH public key
RUN mkdir -p /root/.ssh \
    && echo "${JENKINS_AGENT_SSH_PUBKEY}" >> /root/.ssh/authorized_keys \
    && chmod 600 /root/.ssh/authorized_keys

# Ensure Docker daemon can run
CMD ["sh", "-c", "while :; do sleep 6h & wait $${!}; done"]
USER 1001