#!/bin/sh
set -e

mkdir -p /var/log/mysql
chown mysql:mysql /var/log/mysql

# mysqld's log-file validation rejects a symlink pointing at a character
# device outright (confirmed: "Could not use /var/log/mysql/slow.log for
# logging (error 2 - No such file or directory)" even though the symlink
# genuinely existed) — so slow_query_log_file has to be a real file. Stream
# that real file to this container's actual stdout instead, so
# `docker logs`/`docker compose logs` still shows it. `tail -F` waits for
# the file to be created if it doesn't exist yet, so there's no race with
# mysqld creating it on its own first write.
tail -F /var/log/mysql/slow.log &

exec docker-entrypoint.sh "$@"
