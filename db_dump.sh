#!/usr/bin/env bash

source /home/ubuntu/omeka-s-docker/.env

CONTAINER=omeka-s-docker-omeka-s-db-1
DUMP=/home/ubuntu/ccdevback/sql/dump.sql


docker exec $CONTAINER mariadb-dump --user $DB_USER --password=$DB_PASSWORD --all-databases > $DUMP
