-- Dedicated least-privilege user for the RCA agent (rca-agent, added in
-- v1.2-traces-logs/docker-compose.yml). Same reasoning as
-- metrics_exporter in 003_metrics_user.sql: never reuse the app's own DB
-- user (expense_app), and this account must not be able to write
-- anything — the RCA agent's tool layer (rca-agent/app/security/
-- permissions.py) only ever sends SELECT/SHOW statements through it, but
-- the account itself is the actual enforcement boundary agent-spec.md
-- #21/#70 asks for, not the application code alone.
CREATE USER IF NOT EXISTS 'rca_agent'@'%' IDENTIFIED BY 'rca_agent_devpass';
GRANT SELECT, PROCESS ON *.* TO 'rca_agent'@'%';
GRANT SELECT ON performance_schema.* TO 'rca_agent'@'%';
FLUSH PRIVILEGES;
