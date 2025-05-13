# This container is intended to be used like base common place for the Drupal projects
# currently only tested with 10.x and 11.x version.
# Refs.: https://kb.objectrocket.com/redis/run-redis-with-docker-compose-1055
# https://redis.io/commands/config-set
# https://hub.docker.com/_/redis

# This Dockerfile was created 6/10/2021
# Last updated: 12/05/2025 6:20

# Use an official Redis runtime as a parent image.
FROM redis:8.0

LABEL maintainer="Alejandro Gomez Lagunas <alagunas@coati.com.mx>"

COPY redis.conf /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
