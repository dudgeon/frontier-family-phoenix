-- Base schema for Frontier Family chat
create extension if not exists "pgcrypto";
create extension if not exists "vector";

create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  email text unique,
  full_name text,
  created_at timestamp with time zone default now()
);

create table if not exists chat_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id) on delete cascade,
  created_at timestamp with time zone default now()
);

create table if not exists chat_messages (
  id uuid primary key default gen_random_uuid(),
  session_id uuid references chat_sessions(id) on delete cascade,
  role text check (role in ('user','assistant','system')),
  content text,
  embedding vector(1536),
  created_at timestamp with time zone default now()
);

create table if not exists system_prompts (
  id serial primary key,
  slug text unique,
  content text
);

create table if not exists deletion_audit (
  id uuid primary key default gen_random_uuid(),
  table_name text,
  record_id uuid,
  deleted_at timestamp with time zone default now()
);

-- RLS Policies
alter table users enable row level security;
create policy "users can view self" on users
  for select using (auth.uid() = id);

alter table chat_sessions enable row level security;
create policy "owner access" on chat_sessions
  for all using (auth.uid() = user_id);

alter table chat_messages enable row level security;
create policy "owner session access" on chat_messages
  for all using (exists (select 1 from chat_sessions s where s.id = session_id and s.user_id = auth.uid()));
