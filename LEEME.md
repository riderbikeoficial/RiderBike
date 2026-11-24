# RIDER BIKE — HTML, CSS y JavaScript

Descomprime el ZIP y abre index.html en tu navegador.

# RIDER BIKE Bogotá

Sitio estático HTML5, CSS3 y JavaScript Vanilla.

## Personalizar
- Identidad, teléfono WhatsApp (57 seguido de 10 dígitos), contacto, marcas, precios y catálogo: `assets/js/data.js`.
- Contenido y mapa: `index.html`.
- Diseño: `assets/css/style.css`.
- Interacciones: `assets/js/script.js`.

El catálogo, precios, marcas y testimonios son ficticios. Las fotografías son ilustrativas. Reemplazar datos e imágenes por los autorizados del negocio antes de compartirlo con clientes.

El formulario prepara mensajes para WhatsApp; no almacena ni envía consultas a un servidor. Mientras no se configure el teléfono permite copiar el mensaje. El carrito se conserva en el navegador mediante almacenamiento local; no procesa pagos. El asistente muestra opciones orientativas, no certifica compatibilidad.

Las fichas se pueden enlazar con `#producto-b0`, etc. La integración WebMCP es opcional por detección de soporte y no pudo validarse en un contexto de navegador compatible.

## Antes de publicar
1. Configura el número real de WhatsApp en formato internacional (57 + 10 dígitos), teléfono, correo y dirección en `assets/js/data.js`.
2. Confirma precios, inventario, referencias, marcas y compatibilidades; elimina cualquier producto de ejemplo que no corresponda al negocio.
3. Sustituye testimonios, fotografías y marcas ilustrativas por contenido autorizado y real.
4. Confirma horarios, ubicación exacta, políticas de garantía, cambios, envíos y tratamiento de datos.
5. Prueba el sitio en celular y computador, y realiza pedidos de prueba antes de anunciarlo.

## Mejoras incluidas en esta versión
- El carrito conserva los productos al recargar la página en el mismo navegador.
- El menú móvil se cierra al seleccionar un enlace y al presionar Escape.
- Se añadió un enlace de accesibilidad para saltar directamente al contenido.
- Se retiró el horario fijo de ejemplo para evitar publicar información comercial no confirmada.


## Actualizaciones RIDER BIKE (Underground)

- La interfaz usa una dirección visual dark/industrial con acento naranja.
- El catálogo incluye etiquetas de inventario: Disponible, Agotado y Próximamente.
- El filtro de disponibilidad está en el catálogo.
- En el administrador, el estado de inventario se cambia en el selector correspondiente. 'Producto visible en la tienda' sigue siendo independiente: desmarcarlo oculta el producto; marcar Agotado lo mantiene visible sin permitir agregarlo al carrito.
- Los productos agotados no se pueden agregar al carrito y muestran consulta de reposición por WhatsApp.
- La sección Custom Builds está lista para cambiar sus imágenes de muestra por fotografías reales.

### Configurar WhatsApp

En `assets/js/data.js`, cambia `whatsapp:''` por el número de la tienda con indicativo internacional, solo dígitos. Para Colombia, por ejemplo, el formato es `573001234567` (reemplaza por el número real). Cuando el número está configurado, botones y consultas abrirán WhatsApp con el mensaje preparado. Si está vacío, el sitio mostrará el diálogo para copiar el mensaje.

### Estado de inventario en Supabase

Se agregó el campo `stock_status` (`available`, `soldout`, `coming`). Si ya tienes una base creada, ejecuta la migración indicada al final de `SUPABASE-SETUP.sql` en SQL Editor. La visibilidad pública sigue controlándose con el campo `available`.

**Pendiente de completar con datos reales:** número WhatsApp, fotos propias de custom builds, dirección, horarios, redes sociales y configuración de Supabase.
