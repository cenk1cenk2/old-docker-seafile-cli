# docker-seafile-cli

[![Build Status](https://drone.kilic.dev/api/badges/cenk1cenk2/docker-seafile-cli/status.svg)](https://drone.kilic.dev/cenk1cenk2/docker-seafile-cli) [![Docker Pulls](https://img.shields.io/docker/pulls/cenk1cenk2/seafile-cli)](https://hub.docker.com/repository/docker/cenk1cenk2/seafile-cli) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/cenk1cenk2/seafile-cli)](https://hub.docker.com/repository/docker/cenk1cenk2/seafile-cli) [![Docker Image Version (latest by date)](https://img.shields.io/docker/v/cenk1cenk2/seafile-cli)](https://hub.docker.com/repository/docker/cenk1cenk2/seafile-cli) [![GitHub last commit](https://img.shields.io/github/last-commit/cenk1cenk2/docker-seafile-cli)](https://github.com/cenk1cenk2/docker-seafile-cli)

<!-- toc -->

- [Description:](#description)
- [Setup:](#setup)

<!-- tocstop -->

## Description:

This script runs a seafile-client and syncs the mounted folders in the server. Settings can be adjusted using the ".env" file. All libraries have to be mounted to the `/data` folder with their library ids.

## Setup:

**Fast Deploy**

- `chmod +x ./init-env.sh && ./init-env.sh && nano init-env.sh`
- Add the same library ids under the volumes of `/data/$LIBRARYID`.
