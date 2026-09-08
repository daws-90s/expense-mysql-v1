-- MySQL's error log defaults to a fixed text format via the log_sink_internal
-- component. log_sink_json is a built-in component that formats the same
-- events as JSON instead. Swapping it in for log_sink_internal (not adding
-- it alongside — that would interleave text and JSON lines in the same
-- stream) gives a uniformly-parseable error log with no wrapper/tail hack
-- needed, unlike the slow query log: this still writes to the same
-- destination (stderr, since log_error is unset in this image) that Docker
-- already captures directly.
--
-- The component must be installed before log_error_services can reference
-- it. INSTALL COMPONENT persists into the mysql.component system table
-- (survives restarts, since it lives in the data directory). SET PERSIST
-- writes into mysqld-auto.cnf, also in the data directory — this script
-- runs against a temporary bootstrap instance during first-time init, not
-- the final one, so SET PERSIST (not SET GLOBAL) is what makes the setting
-- actually take effect on the real startup that follows.
INSTALL COMPONENT 'file://component_log_sink_json';
SET PERSIST log_error_services = 'log_filter_internal; log_sink_json';
