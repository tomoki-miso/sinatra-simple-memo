CREATE TABLE IF NOT EXISTS memos (
  id      serial       PRIMARY KEY,
  title   varchar(255) NOT NULL,
  content text         NOT NULL DEFAULT ''
);
