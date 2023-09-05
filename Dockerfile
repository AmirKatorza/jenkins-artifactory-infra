# step 1:
ARG JENKINS_IMAGE=docker.io/jenkins/jenkins
ARG JENKINS_TAG=lts
FROM "${JENKINS_IMAGE}:${JENKINS_TAG}"

# step 2:Install lugins
COPY plugins.txt plugins.txt
RUN jenkins-plugin-cli --plugin-file plugins.txt


# step 3: Install AWS CLI
USER root
RUN apt-get update
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# step 4:
RUN curl -fsSL https://get.docker.com | sh

# step 5:
RUN usermod -aG docker jenkins

# step 6:
ARG HOST_DOCKER_GID
RUN groupmod -g "$HOST_DOCKER_GID" docker

# step 7:
USER jenkins