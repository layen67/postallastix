#!/bin/sh
cd /var/lib/docker/postallastix
docker-compose up -d
sleep 10
docker-compose run postal start
