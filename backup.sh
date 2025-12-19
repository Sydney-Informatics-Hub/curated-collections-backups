#!/usr/bin/env bash

source /home/ubuntu/ccdevback/.secrets/openstack_creds.sh

printf -v TIMESTAMP "%(%Y%m%d_%H%M%S)T" -1

FOLDER=/home/ubuntu/ccdevback/sql/
FILE=${FOLDER}/${TIMESTAMP}.sql

CONTAINER=cc-dev-backup
OBJECT_FOLDER=carceral


cp ${FOLDER}/dump.sql $FILE

/home/ubuntu/.local/bin/uv run \
                           --project /home/ubuntu/ccdevback/ \
	swift upload --object-name "${OBJECT_FOLDER}/db_${TIMESTAMP}.sql" \
	             $CONTAINER \
	             $FILE

rm $FILE
