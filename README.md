# Jenkins-Artifactory Infra

This project sets up a Jenkins-Artifactory infrastructure using Docker.

## Prerequisites

- An EC2 instance up and running.
- Docker and Docker Compose installed on the EC2 instance.
- `unzip` utility installed.

## How to Use

1. Clone this repository to your EC2 instance:
    git clone <repository-url>

2. Navigate to the project directory:
    cd <repository-directory-name>

3. Execute the get_env.sh script:
    ./get_env.sh

4. Ensure that the .env file was created:
    ls -la | grep .env

5. Build and start the Docker services:
    docker-compose build && docker-compose up