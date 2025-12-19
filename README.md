Simple db dumps

db_dump.sh: runs mariadb-dump via docker to get the sql into ./sql
backup.sh: runs a non-root cron job which copies the sql into object storage

The uv Python project is here to manage dependencies for the swift client
(swift is OpenStack's object storage)

