#!/bin/bash

CONFIG=$1

if [ ! -f "$CONFIG" ] ; then
    echo "The file \"$CONFIG\" does not exist!"
    exit 1
fi

docker-compose -f $CONFIG pull --include-deps -q transmission
docker image prune -f
docker-compose -f $CONFIG up -d --force-recreate --always-recreate-deps transmission
