create table if not exists public.maison_app_state (
  id text primary key,
  state jsonb not null default '{}'::jsonb,
  custom_items jsonb not null default '{}'::jsonb,
  participants jsonb not null default '[]'::jsonb,
  contributions jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.maison_app_state enable row level security;

drop policy if exists "Famille peut lire" on public.maison_app_state;
drop policy if exists "Famille peut modifier" on public.maison_app_state;

create policy "Famille peut lire"
on public.maison_app_state
for select
to anon
using (true);

create policy "Famille peut modifier"
on public.maison_app_state
for all
to anon
using (true)
with check (true);

do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'maison_app_state'
  ) then
    alter publication supabase_realtime add table public.maison_app_state;
  end if;
end $$;
