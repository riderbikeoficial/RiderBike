-- Ejecuta este script en Supabase > SQL Editor.
-- La tabla permite lectura pública del catálogo; escritura solo al usuario con app_metadata.role=admin.
create extension if not exists pgcrypto;
create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text not null check (category in ('Bicicletas','Repuestos','Accesorios','Herramientas','Equipamiento')),
  brand text default '',
  price numeric(12,2) not null default 0 check (price >= 0),
  old_price numeric(12,2) check (old_price is null or old_price >= 0),
  reference text,
  type text,
  description text,
  sizes text[] not null default '{}',
  colors text[] not null default '{}',
  badge text,
  available boolean not null default true,
  stock_status text not null default 'available' check (stock_status in ('available','soldout','coming')), 
  image_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.products enable row level security;
drop policy if exists "Public can read visible products" on public.products;
create policy "Public can read visible products" on public.products for select using (available = true);
drop policy if exists "Authenticated admin can read all products" on public.products;
create policy "Authenticated admin can read all products" on public.products for select to authenticated using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
drop policy if exists "Authenticated admin can insert products" on public.products;
create policy "Authenticated admin can insert products" on public.products for insert to authenticated with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
drop policy if exists "Authenticated admin can update products" on public.products;
create policy "Authenticated admin can update products" on public.products for update to authenticated using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin') with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
drop policy if exists "Authenticated admin can delete products" on public.products;
create policy "Authenticated admin can delete products" on public.products for delete to authenticated using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('product-images','product-images',true,5242880,array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public=true,file_size_limit=5242880,allowed_mime_types=array['image/jpeg','image/png','image/webp'];
drop policy if exists "Public can view product images" on storage.objects;
create policy "Public can view product images" on storage.objects for select using (bucket_id='product-images');
drop policy if exists "Authenticated admin can upload product images" on storage.objects;
create policy "Authenticated admin can upload product images" on storage.objects for insert to authenticated with check (bucket_id='product-images' and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
drop policy if exists "Authenticated admin can update product images" on storage.objects;
create policy "Authenticated admin can update product images" on storage.objects for update to authenticated using (bucket_id='product-images' and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin') with check (bucket_id='product-images' and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
drop policy if exists "Authenticated admin can delete product images" on storage.objects;
create policy "Authenticated admin can delete product images" on storage.objects for delete to authenticated using (bucket_id='product-images' and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

-- Después de crear el usuario administrador en Authentication > Users,
-- cambia el correo por el correo real y ejecuta esta sentencia para darle el rol admin:
-- update auth.users set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{\"role\":\"admin\"}'::jsonb where email = 'TU_CORREO_ADMIN';

-- Migración para instalaciones existentes:
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS stock_status text NOT NULL DEFAULT 'available' CHECK (stock_status IN ('available','soldout','coming'));
