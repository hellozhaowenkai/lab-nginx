# lab-nginx

[![Maintainer](https://img.shields.io/badge/Maintainer-KevInZhao-42b983.svg)](https://github.com/hellozhaowenkai/)

🌏 The service connectivity platform for our microservices architecture, powered by NGINX. 🤩

- [Quickstart](#quickstart)
- [Usage](#usage)

## Quickstart

### Get repository

```bash
# Clone repository.
git clone --recursive https://github.com/hellozhaowenkai/lab-nginx.git
# Then into the project root directory.
cd lab-nginx
```

### Build image

```bash
docker image build --tag=lab-nginx:latest $PWD
```

### Run container

```bash
docker container run \
  --user     $(id -u) \
  --name     lab-nginx \
  --publish  80:80 \
  --publish  443:443 \
  --publish  8888:8888 \
  --volume   $PWD/config:/app/config \
  --volume   $PWD/logs:/app/logs \
  --volume   $PWD/html:/app/html \
  --restart  on-failure:3 \
  --interactive \
  --detach \
  lab-nginx:latest
```

### View log

```bash
docker container logs lab-nginx
```

### Restart container

```bash
docker container restart lab-nginx
```

### Delete container & image

```bash
docker container rm -f lab-nginx
docker image rm lab-nginx:latest
```

## Usage

### Update the code

```bash
# Pull repository with submodules.
git pull --recurse-submodules=on-demand
# Pull repository force to overwrite local files.
git fetch --all && git reset --hard origin/main && git pull
```

### Running NGINX in the foreground without Docker

```bash
nginx -g 'daemon off;' -p $PWD -c $PWD/config/nginx.conf
```

### Copy the default configuration from a running NGINX container

```bash
docker container run --name=tmp-nginx-container --detach nginx:stable
docker container cp tmp-nginx-container:/etc/nginx/nginx.conf $PWD/config/nginx.conf
docker container rm -f tmp-nginx-container
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
