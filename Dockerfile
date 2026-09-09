FROM mysql:8.0

ENV MYSQL_DATABASE=expense_tracker

COPY migrations/001_init.sql /docker-entrypoint-initdb.d/001_init.sql
COPY migrations/002_seed_categories.sql /docker-entrypoint-initdb.d/002_seed_categories.sql
COPY migrations/003_metrics_user.sql /docker-entrypoint-initdb.d/003_metrics_user.sql
# Switches the error log to JSON (log_sink_json) on first init — see the
# migration file for why this has to happen via INSTALL COMPONENT + SET
# PERSIST rather than a my.cnf setting.
COPY migrations/004_json_error_log.sql /docker-entrypoint-initdb.d/004_json_error_log.sql
# Read-only account for rca-agent (v1.2-traces-logs/rca-agent) — see the
# migration file's own comment for why this is a separate user from
# metrics_exporter above.
COPY migrations/005_rca_readonly_user.sql /docker-entrypoint-initdb.d/005_rca_readonly_user.sql

# Error log still goes to stderr by default in this image (only its format
# changed, via 004_json_error_log.sql above — nothing else to configure).
# Slow query log is off by default, so turn it on; see
# docker-entrypoint-wrapper.sh for how its file gets streamed to stdout
# (mysqld refuses to log directly to a symlinked stdout, unlike nginx).
COPY conf.d/slow-query-log.cnf /etc/mysql/conf.d/slow-query-log.cnf
COPY docker-entrypoint-wrapper.sh /usr/local/bin/docker-entrypoint-wrapper.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-wrapper.sh

ENTRYPOINT ["docker-entrypoint-wrapper.sh"]
CMD ["mysqld"]
