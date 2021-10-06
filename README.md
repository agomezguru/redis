# Quick reference, Redis

Configured redis server for deploy Drupal 8.x and 9.x based projects

- **Maintained by**:
[agomezguru](https://github.com/agomezguru)

- **Where to get help**:  
[Docker Official Images: redis](https://hub.docker.com/_/redis/)

## Supported tags and respective `Dockerfile` links

- [`latest`](https://github.com/agomezguru/redis)

## How to use this image

The intent of this image is always being together use with a NGINX docker container and MySQL/MariaDB/Percona database with a simple `Dockerfile` (in `/host/path/`) like this one:

```bash
cat <<EOF > docker-compose.yml
version: '3'

volumes:
  my-public:
    external: true
  my-db-data:
    external: true

services:
  web:
    image: agomezguru/nginx:laravel-5x
    ports:
      - "$outsidePort:80"
    environment:
      - HOST_NAME=myAppHostName
      - LOG_STATUS=on
      - LOG_NAME=myAppLogName
      - DEPLOYMENT_STAGE=develop
      - PHP_CONTAINER_NAME=php
    volumes:
      - ../someCode:/srv
      - my-public:/srv/public
    networks:
      - $env-network

  php:
    image: agomezguru/drupal:9.x-php7.4.23
    volumes:
      - ../someCode:/srv
      - my-public:/srv/public
      - ./php-composer.ini:/usr/local/etc/php/conf.d/custom.ini
    networks:
      - $env-network

  redis:
    image: agomezguru/redis:latest
    networks:
      - $env-network

  db:
    image: percona:5.7.35
    volumes:
      - my-db-data:/var/lib/mysql
      - ../percona/masterdb/config:/etc/mysql/conf.d
      - ../dumps:/backups-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: $envPassword
    networks:
      - $env-network

# Isolate docker containers arrays between environments.
networks:
  $env-network:
    driver: bridge
EOF
```

### Using environment variables in redis configuration

This container image doesn't support any environment variables.

## License

View [Redis license and trademark information](https://redis.io/topics/license) for the software contained in this image.

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
