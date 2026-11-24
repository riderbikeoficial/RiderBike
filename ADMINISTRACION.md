# Panel de administración RIDER BIKE

## Incluye
- Acceso privado con correo y contraseña (sin registro público).
- Alta, edición, ocultar/mostrar y eliminación de productos.
- Subida de imagen principal JPG/PNG/WebP (máximo 5 MB).
- Tabla y almacenamiento en Supabase.

## Puesta en marcha
1. Crea un proyecto en https://supabase.com/.
2. En Authentication > Providers, deja habilitado Email. Desactiva el registro público (Authentication > Settings / User Signups).
3. En Authentication > Users, crea/invita manualmente **un único usuario administrador** con el correo que usarás. No compartas esa cuenta.
4. Abre SQL Editor, pega y ejecuta `SUPABASE-SETUP.sql`.
5. En el mismo SQL Editor, ejecuta la sentencia comentada al final del archivo para asignar `role=admin` a tu correo (reemplaza `TU_CORREO_ADMIN`).
6. En Project Settings > API, copia Project URL y la clave `anon`/publishable.
7. Pega ambos valores en `assets/js/supabase-config.js`. Nunca uses `service_role` ni una secret key en el navegador.
8. Publica los archivos en tu hosting y abre `/admin/login.html`.

## Seguridad
- RLS está habilitado. La tienda solo puede leer productos `available=true`.
- Las operaciones de escritura requieren una sesión autenticada con `app_metadata.role=admin`.
- Las políticas RLS y las políticas de Storage verifican ese rol. Mantén desactivados los registros públicos y no crees cuentas adicionales.

## Catálogo público
`assets/js/store-sync.js` consulta los productos visibles de Supabase y los muestra en la tienda. Si Supabase no está configurado o la consulta falla, la web conserva el catálogo local de demostración. Configura primero las credenciales y el proyecto.
