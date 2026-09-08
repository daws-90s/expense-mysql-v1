-- System default categories (user_id NULL = shared across all tenants)
INSERT INTO categories (user_id, name, icon_key, color_hex) VALUES
  (NULL, 'Food',          'UtensilsCrossed', '#E8873A'),
  (NULL, 'Transport',     'Car',             '#3B82C4'),
  (NULL, 'Housing',       'Home',            '#8B6F47'),
  (NULL, 'Health',        'HeartPulse',      '#E15251'),
  (NULL, 'Entertainment', 'Popcorn',         '#A855C4'),
  (NULL, 'Shopping',      'ShoppingBag',     '#D6438B'),
  (NULL, 'Travel',        'Plane',           '#2BA6A4'),
  (NULL, 'Bills',         'Receipt',         '#6B7280'),
  (NULL, 'Education',     'GraduationCap',   '#4C6EF5'),
  (NULL, 'Other',         'MoreHorizontal',  '#8891A8');
