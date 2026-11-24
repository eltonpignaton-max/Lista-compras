-- Executar em um projeto Supabase novo e exclusivo para a lista.
create table public.produtos (
 id uuid primary key default gen_random_uuid(),
 quantidade numeric not null check (quantidade > 0),
 unidade text not null check (length(trim(unidade)) > 0),
 tipo text not null check (tipo in ('F','G','O')),
 descricao text not null check (length(trim(descricao)) > 0),
 comprado boolean not null default false,
 manual boolean not null default false
);
alter table public.produtos enable row level security;
create policy acesso on public.produtos for all to authenticated using (true) with check (true);
revoke all on public.produtos from anon;
grant select, insert, update, delete on public.produtos to authenticated;
create function public.substituir_lista(itens jsonb) returns void language plpgsql security invoker set search_path = '' as $$
begin
 if jsonb_typeof(itens) is distinct from 'array' or jsonb_array_length(itens)=0 then raise exception 'Lista vazia ou inválida'; end if;
 lock table public.produtos in exclusive mode;
 delete from public.produtos;
 insert into public.produtos (quantidade,unidade,tipo,descricao)
 select quantidade,unidade,tipo,descricao from jsonb_to_recordset(itens) as x(quantidade numeric,unidade text,tipo text,descricao text);
end; $$;
revoke all on function public.substituir_lista(jsonb) from public, anon;
grant execute on function public.substituir_lista(jsonb) to authenticated;
alter publication supabase_realtime add table public.produtos;
