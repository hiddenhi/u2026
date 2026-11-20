CREATE TABLE IF NOT EXISTS inquiries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  category TEXT,
  product TEXT,
  name TEXT,
  email TEXT,
  whatsapp TEXT,
  country TEXT,
  quantity TEXT,
  message TEXT,
  status TEXT DEFAULT 'new',
  remark TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
