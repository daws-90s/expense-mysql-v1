-- Dedicated least-privilege user for mysqld-exporter (Prometheus scraping).
-- Never reuse the app's own DB user (expense_app) for this — the exporter
-- only needs read access to server/replication status and performance_schema,
-- nothing on application tables.
CREATE USER IF NOT EXISTS 'metrics_exporter'@'%' IDENTIFIED BY 'metrics_exporter_devpass';
GRANT PROCESS, REPLICATION CLIENT ON *.* TO 'metrics_exporter'@'%';
GRANT SELECT ON performance_schema.* TO 'metrics_exporter'@'%';
FLUSH PRIVILEGES;
