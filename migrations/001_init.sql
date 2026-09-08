-- Expense Tracker — initial schema
-- Multi-tenant: every user-owned row is scoped by user_id

CREATE TABLE IF NOT EXISTS users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  display_name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login_at TIMESTAMP NULL,
  UNIQUE KEY uq_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS categories (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NULL,
  name VARCHAR(100) NOT NULL,
  icon_key VARCHAR(50) NOT NULL,
  color_hex VARCHAR(7) NOT NULL,
  CONSTRAINT fk_categories_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  KEY idx_categories_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS expenses (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  category_id BIGINT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  description VARCHAR(255) NULL,
  expense_date DATE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_expenses_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_expenses_category FOREIGN KEY (category_id) REFERENCES categories(id),
  KEY idx_expenses_user (user_id),
  KEY idx_expenses_user_date (user_id, expense_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
