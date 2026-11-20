#!/usr/bin/env bash

source /srv/backups/.secrets/openstack_creds.sh

printf -v TIMESTAMP "%(%Y%m%d_%H%M%S)T" -1

BASEDIR=/srv/backups

SQL=${BASEDIR}/sql
TODAY="${BASEDIR}/_days/${TIMESTAMP}"

mkdir -p $TODAY

CONTAINER=cc-sih-multitenant-backup

cp $SQL/*.sql $TODAY/

for SQLFILE in $TODAY/*.sql
do
	BASEFILE=$(basename $SQLFILE)
	OBJECT="${TIMESTAMP}/${BASEFILE}"
	/home/ubuntu/.local/bin/uv run --project /srv/backups/ \
	    swift upload --object-name $OBJECT $CONTAINER $SQLFILE
done

# TODO: lea
