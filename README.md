# lab-nginx

[![Maintainer](https://img.shields.io/badge/Maintainer-KevInZhao-42b983.svg)](https://github.com/hellozhaowenkai/)
[![Version](https://img.shields.io/github/v/tag/hellozhaowenkai/lab-nginx?label=Version)](https://github.com/hellozhaowenkai/lab-nginx/tags/)
[![NGINX](https://img.shields.io/badge/NGINX-%3E%3D1.21-success)](https://nginx.org/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196)](https://conventionalcommits.org/)
[![License](https://img.shields.io/github/license/hellozhaowenkai/lab-nginx?label=License)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)](CODE_OF_CONDUCT.md)

🌏 The service connectivity platform for our microservices architecture, powered by NGINX. 🤩

- [Quickstart](#quickstart)
- [Usage](#usage)

## Quickstart

### Get repository

```bash
# Clone repository with submodules.
git clone --recursive https://github.com/hellozhaowenkai/lab-nginx.git
# Then into the project root directory.
cd lab-nginx
```

### Update the code

```bash
# Pull repository with submodules.
git pull --recurse-submodules=on-demand
# Pull repository force to overwrite local files.
git fetch --all && git reset --hard origin/main && git pull
```

### Launch container

```bash
# Run [Deploy Script](ops/deploy.sh).
sh ops/deploy.sh
```

### Restart container

```bash
# Do it if you know what it mean.
docker container restart lab-nginx
```

## Usage

### Git LFS

See [Git Large File Storage](https://git-lfs.github.com/).

### Create the lab-net network

```
docker network create --driver=bridge lab-net
```

### Copy the default configuration from a running NGINX container

```bash
docker container run --name=tmp-nginx-container --detach nginx:stable
docker container cp tmp-nginx-container:/etc/nginx/. $PWD/config/
docker container rm -f tmp-nginx-container
```

### Running NGINX in the foreground without Docker

```bash
nginx -g 'daemon off;' -p $PWD -c $PWD/config/nginx.conf
```

### Issue the SSL certificate via NGINX container by acme.sh

> NOTE: Maybe you need change `$PWD/config/servers/host.conf` first to run the script below.

```bash
acme.sh --issue \
  --server     zerossl \
  --domain     example.com \
  --domain     '*.example.com' \
  --keylength  ec-256 \
  --webroot    $PWD/config/html/home/latest/
```

### Install the SSL certificate to NGINX container by acme.sh

```bash
acme.sh --install-cert --ecc \
  --domain          example.com \
  --fullchain-file  $PWD/config/ssl/cert.pem \
  --key-file        $PWD/config/ssl/cert.key \
  --ca-file         $PWD/config/ssl/cert.ca \
  --reloadcmd       'docker container restart lab-nginx'
```
