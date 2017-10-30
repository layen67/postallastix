#!/bin/sh
cd /var/lib/docker/postallastix
docker-compose up -d
docker-compose run postal start
