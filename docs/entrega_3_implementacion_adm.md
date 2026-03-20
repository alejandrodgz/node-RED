# Implementación del Módulo ADM — Node-RED / Evergreen

**Curso**: Herramientas para la Industrialización del Desarrollo de Software  
**Equipo**: Daniel Garcia, Juan Esteban Quintero, Simon Ortiz  
**Fecha**: Marzo 2026  

---

## Resumen de cambios

Este documento describe la implementación completa del módulo **ADM (Administración)** del caso de estudio **Evergreen** en Node-RED. Los cambios se realizaron sobre `data/flows.json`.

---

## P1a — Asignar Rol a Usuario

**Tab:** `tab-usuarios`  
**UI Group:** `ui-group-asignar-rol` → "Asignar Rol a Usuario"

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-asignar-rol` | `ui_form` | Formulario con campos: ID del Usuario, ID del Rol |
| `fn-asignar-rol` | `function` | Busca el usuario y el rol en el storage global, asigna `rol_id` al usuario |

### Lógica de `fn-asignar-rol`

```javascript
// Busca usuario y rol por ID
// Si alguno no existe → devuelve mensaje de error ❌
// Si existen → asigna usuario.rol_id = rol.id
// Actualiza global.usuarios
// Dispara notificación + refresco de tabla
```

### Efectos secundarios

- La tabla de usuarios (`tabla-usuarios`) ahora incluye la columna **Rol** que resuelve el nombre del rol a partir de `rol_id`.
- Se actualizó `fn-refrescar-tabla-usuarios` para mapear `rol_id → nombre del rol`.

---

## P1b — Cambiar Estado de Usuario

**Tab:** `tab-usuarios`  
**UI Group:** `ui-group-estado-usuario` → "Cambiar Estado de Usuario"

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-estado-usuario` | `ui_form` | Formulario con campos: ID del Usuario, Nuevo Estado |
| `fn-cambiar-estado-usuario` | `function` | Valida que el estado sea "Activo" o "Inactivo", actualiza el usuario |

### Validaciones

- El estado enviado debe ser exactamente `"Activo"` o `"Inactivo"` (case-sensitive).
- Si el usuario no existe → retorna error ❌ con el ID enviado.

---

## P2a — UI de Permisos

**Tab:** `tab-acceso`  
**UI Group:** `ui-group-permisos` → "Permisos"

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-permiso` | `ui_form` | Formulario para crear un nuevo permiso (nombre) |
| `fn-guardar-permiso` | `function` | Valida duplicados por nombre (case-insensitive), guarda en `global.permisos` |
| `fn-refrescar-permisos` | `function` | Prepara array para la tabla |
| `tabla-permisos` | `ui_table` | Muestra ID, Nombre, Fecha de creación |
| `btn-refrescar-permisos` | `ui_button` | Dispara refresco manual de la tabla |

### Estructura de un Permiso en storage

```json
{
  "id": "1234567890",
  "nombre": "Ver",
  "fecha_creacion": "2026-03-19T00:00:00.000Z"
}
```

---

## P2b — Asignar Permiso a Rol

**Tab:** `tab-acceso`  
**UI Group:** `ui-group-asignar-permiso` → "Asignar Permiso a Rol"

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-asignar-permiso` | `ui_form` | Formulario con campos: ID del Rol, ID del Permiso |
| `fn-asignar-permiso-rol` | `function` | Valida existencia de rol y permiso, evita duplicados, agrega `permiso.id` al array `rol.permisos[]` |

### Refactor de la estructura de Roles (P4-parcial)

Los roles ahora tienen el campo `permisos: []`:

```json
{
  "id": "1",
  "nombre": "Admin",
  "fecha_creacion": "...",
  "permisos": ["1", "2", "3"]
}
```

La tabla de roles (`tabla-roles`) fue actualizada para mostrar la columna **Permisos Asignados** resolviendo los IDs a nombres.

---

## P3a — Módulos del Sistema

**Tab:** `tab-modulos` *(tab nuevo)*  
**UI Group:** `ui-group-modulos` → "Módulos del Sistema"  
**UI Tab del Dashboard:** `ui-tab-modulos` (orden 5, ícono `view_module`)

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-modulo` | `ui_form` | Formulario para crear un módulo (nombre) |
| `fn-guardar-modulo` | `function` | Valida duplicados por nombre, guarda en `global.modulos` |
| `fn-refrescar-modulos` | `function` | Prepara array para la tabla |
| `tabla-modulos` | `ui_table` | Muestra ID, Nombre |
| `btn-refrescar-modulos` | `ui_button` | Refresco manual |
| `notif-modulos` | `ui_toast` | Notificaciones de éxito/error del tab |

### Estructura de un Módulo en storage

```json
{ "id": "1234567890", "nombre": "ADM" }
```

---

## P3b — Páginas

**Tab:** `tab-modulos`  
**UI Group:** `ui-group-paginas` → "Páginas"

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-pagina` | `ui_form` | Formulario: nombre + ruta (ej: `/usuarios`) |
| `fn-guardar-pagina` | `function` | Valida ruta duplicada, guarda con `opciones: []` |
| `fn-refrescar-paginas` | `function` | Prepara array para la tabla (muestra conteo de opciones) |
| `tabla-paginas` | `ui_table` | Muestra ID, Nombre, Ruta, Nº Opciones |
| `btn-refrescar-paginas` | `ui_button` | Refresco manual |

### Estructura de una Página en storage

```json
{
  "id": "1234567890",
  "nombre": "Gestión de Usuarios",
  "ruta": "/usuarios",
  "opciones": []
}
```

---

## P3c — Opciones (composición con Página)

**Tab:** `tab-modulos`  
**UI Group:** `ui-group-opciones` → "Opciones de Páginas"

### Nodos añadidos

| ID | Tipo | Descripción |
|---|---|---|
| `form-opcion` | `ui_form` | Formulario: ID Página, nombre, URL, ID Módulo (opcional) |
| `fn-guardar-opcion` | `function` | Busca la página por ID, le agrega la opción como elemento de `pagina.opciones[]` |

### Relación Opción → Página (composición)

Una Opción vive dentro de su Página en el storage. Si la Página se elimina, sus Opciones desaparecen con ella. Esto refleja la relación de **composición** del modelo de dominio.

```json
{
  "id": "111",
  "nombre": "Ver Usuarios",
  "url": "/usuarios/listado",
  "modulo_id": "1"
}
```

---

## P4 — Refactor TipoUsuario como entidad

**Archivo afectado:** `fn-init-storage` en `tab-agrocadenas`

### Antes

```javascript
global.set('tiposUsuario', ['Administrador', 'Operador', 'Invitado']);
```

### Después

```javascript
global.set('tiposUsuario', [
  { id: '1', nombre: 'Administrador' },
  { id: '2', nombre: 'Operador' },
  { id: '3', nombre: 'Invitado' }
]);
```

`TipoUsuario` ahora es una entidad con `id` y `nombre`, alineada al modelo de dominio.

El nodo `fn-cargar-maestro` en `tab-maestro` fue actualizado para manejar ambos formatos (objeto o string) con retrocompatibilidad.

---

## Estado del módulo ADM tras la implementación

| Entidad | Estado |
|---|---|
| `TipoUsuario` | ✅ Entidad con id/nombre en `tiposUsuario` |
| `Usuario` | ✅ CRUD completo + asignación de rol + cambio de estado |
| `Rol → Admin / Invitado` | ✅ CRUD + permisos asignados visibles en tabla |
| `Permiso` | ✅ CRUD completo con UI |
| Asignación Rol → Permiso | ✅ Formulario + lógica de asignación |
| Asignación Usuario → Rol | ✅ Formulario + lógica de asignación |
| `Modulo` | ✅ CRUD completo |
| `Pagina` | ✅ CRUD completo |
| `Opcion` (composición con Pagina) | ✅ Agregar opciones a páginas por ID |
| `TablaMaestro` | ✅ Catálogos con soporte para nuevo formato TipoUsuario |

---

## Notas técnicas

- **Almacenamiento**: todo usa `global.set/get` de Node-RED (memoria en RAM del contenedor). Los datos se pierden si el contenedor se reinicia. Para producción se recomienda migrar a MongoDB o PostgreSQL.
- **IDs**: se generan con `Date.now().toString()` — suficiente para desarrollo; en producción usar UUID.
- **Retrocompatibilidad**: si el contenedor ya tiene datos en el storage con el formato antiguo de `tiposUsuario` (array de strings), `fn-cargar-maestro` los maneja correctamente sin romper la UI.
- **Para resetear el storage**: reiniciar el contenedor con `docker compose restart` limpia la memoria y vuelve a inicializar los valores por defecto.
