-- Seed data for branch databases
insert into users (id, email, full_name) values
  ('00000000-0000-0000-0000-000000000001', 'parent@example.com', 'Parent User'),
  ('00000000-0000-0000-0000-000000000002', 'child@example.com', 'Child User');

insert into chat_sessions (id, user_id) values
  ('00000000-0000-0000-0000-000000000100', '00000000-0000-0000-0000-000000000001');

insert into chat_messages (session_id, role, content) values
  ('00000000-0000-0000-0000-000000000100', 'user', 'Hello world');
