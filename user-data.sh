#!/bin/sh

# Docker CE for Linux installation script
curl -fsSL https://get.docker.com | sh
# Add the uid=1000 user to "docker" group
groupadd docker
usermod -aG docker $(id --user 1000 --name)