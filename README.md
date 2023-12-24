# Dokku Private Registry

Private registry server deployed as a dokku app with HTTP Basic auth using
`AUTH_USER` and `AUTH_PASSWORD` env variables.

## Setup

```bash
dokku apps:create docker-registry
dokku config:set docker-registry REGISTRY_HTTP_SECRET=$(openssl rand -hex 64)
dokku config:set docker-registry AUTH_USER=user AUTH_PASSWORD=$(openssl rand -hex 16)
dokku storage:mount docker-registry /var/lib/dokku/data/storage/docker-registry:/var/lib/registry
dokku ps:set-restart-policy docker-registry unless-stopped
dokku domains:add docker-registry docker-registry.example.com
dokku letsencrypt docker-registry
```

## Deploy

```bash
git remote add dokku dokku@dokku.example.com:docker-registry
git push dokku master
```

## Test

```bash
docker login -u user -p password docker-registry.example.com

docker pull busybox:latest
docker tag busybox:latest docker-registry.example.com/user/busybox:latest
docker push docker-registry.example.com/user/busybox:latest
docker rmi busybox:latest docker-registry.example.com/user/busybox:latest
docker pull docker-registry.example.com/user/busybox:latest
```

## Garbage Collect

```bash
dokku run docker-registry /bin/registry garbage-collect /app/config.yml
```
