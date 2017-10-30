#!/bin/sh
cd /var/lib/docker/postallastix/yml
docker-compose up -d
docker-compose run postal start
