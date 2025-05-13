# Quick reference, Redis

Configured redis server for deploy Drupal 10.x and 11.x based projects

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
volumes:
  my-public:
    external: true
  my-db-data:
    external: true

services:
  web:
    image: nginx:latest
    ports:
      - "80:8080"
    volumes:
      - ../someCode:/srv
      - my-public:/srv/public
    networks:
      - production-network

  php:
    image: agomezguru/drupal:10.x-php8.3.8im
    volumes:
      - ../someCode:/srv
      - my-public:/srv/public
      - ./php-composer.ini:/usr/local/etc/php/conf.d/custom.ini
    networks:
      - production-network

  redis:
    image: agomezguru/redis:latest
    networks:
      - production-network

  db:
    image: percona:8.0.34-26
    volumes:
      - my-db-data:/var/lib/mysql
      - ../percona/masterdb/config:/etc/mysql/conf.d
      - ../percona/dumps:/backups-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: $environmentPassword
    networks:
      - production-network

# Isolate docker containers arrays between environments.
networks:
  production-network:
    driver: bridge
EOF
```

### Using environment variables in redis configuration

This container image doesn't support any environment variables.

## License

View [Redis license and trademark information](https://redis.io/topics/license) for the software contained in this image.

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
