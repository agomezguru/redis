# This container is intended to be used like base common place for the Drupal projects
# currently only tested with 9 version.
# Refs.: https://kb.objectrocket.com/redis/run-redis-with-docker-compose-1055
# https://redis.io/commands/config-set
# http://www.thetopsites.net/article/50628999.shtml
# https://hub.docker.com/_/redis

# This Dockerfile was created 6/10/2021
# Last updated: 6/10/2021 14:29

# Use an official Redis runtime as a parent image.
FROM redis:latest

LABEL maintainer "Alejandro Gomez Lagunas <alagunas@coati.com.mx>"

COPY redis.conf /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]