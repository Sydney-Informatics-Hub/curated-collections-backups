#!/usr/bin/env bash

# loop over all of /srv/projects, get the db password from the secrets
# file, and then dump the database to ./sql/${PROJECT}.sql"

PROJECTS=/srv/projects
DB_USER=omekas
BASEDIR=/srv/backups/sql
CONTAINER="omeka-s-db-1"

mkdir -p ${BASEDIR}

for PROJDIR in ${PROJECTS}/*/
do
    	PROJECT=$(basename $PROJDIR)
    	echo $PROJECT
	DB_PASSWORD=$(<"${PROJDIR}secrets/mariadb_password.txt")
	DB_CONTAINER="${PROJECT}-${CONTAINER}"
	docker exec $DB_CONTAINER mariadb-dump --user $DB_USER --password="$DB_PASSWORD" --all-databases > "${BASEDIR}/${PROJECT}.sql"
done

