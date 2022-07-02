#!/usr/bin/env bash

# Delete container & image
docker container rm -f lab-nginx
docker image rm lab-nginx:latest

# Build image
docker image build --tag=lab-nginx:latest $PWD

# Run container
docker container run \
  --user     $(id -u) \
  --name     lab-nginx \
  --network  lab-net \
  --publish  80:80 \
  --publish  443:443 \
  --publish  8888:8888 \
  --volume   $PWD/config:/app/config \
  --volume   $PWD/logs:/app/logs \
  --volume   $PWD/html:/app/html \
  --restart  unless-stopped \
  --interactive \
  --detach \
  lab-nginx:latest

# View log
docker container logs lab-nginx
