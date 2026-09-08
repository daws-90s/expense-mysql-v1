# expense-mysql-v1

Schema and seed data for the Expense Tracker. Applied automatically on first
container start via `/docker-entrypoint-initdb.d`, in numeric order:

1. `001_init.sql` — `users`, `categories`, `expenses` tables + indexes
2. `002_seed_categories.sql` — the 10 system default categories (`user_id IS NULL`)

## Standalone use

```
docker build -t expense-mysql-v1 .
docker run -e MYSQL_ROOT_PASSWORD=devpass -p 3306:3306 expense-mysql-v1
```

Normally this is built and started by the root `docker-compose.yml` alongside
the backend and frontend.
