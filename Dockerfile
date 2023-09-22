# Step 1: Base Image
ARG JENKINS_IMAGE=docker.io/jenkins/jenkins
ARG JENKINS_TAG=lts
FROM "${JENKINS_IMAGE}:${JENKINS_TAG}"

# Step 2: Install plugins
COPY plugins.txt plugins.txt
RUN jenkins-plugin-cli --plugin-file plugins.txt

# Step 3: Install Terraform
USER root
RUN apt-get update && \
    apt-get install -y gnupg software-properties-common wget unzip && \
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Step 4: Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip

# Step 5: Install Docker
RUN curl -fsSL https://get.docker.com | sh

# Step 6: Add jenkins to docker group
RUN usermod -aG docker jenkins

# Step 7: Modify Docker GID
ARG HOST_DOCKER_GID
RUN groupmod -g "$HOST_DOCKER_GID" docker

# Step 8: Switch back to Jenkins user
USER jenkins