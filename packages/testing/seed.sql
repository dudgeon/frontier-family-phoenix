insert into users (id, email, full_name) values
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'adult@example.com', 'Parent A'),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'child1@example.com', 'Child B'),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'child2@example.com', 'Child C');

insert into chat_sessions (id, user_id) values
  ('11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa');

insert into chat_messages (session_id, role, content) values
  ('11111111-1111-1111-1111-111111111111', 'user', 'Hello');
