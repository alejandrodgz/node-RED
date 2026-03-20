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

---

## P5 — Corrección bug formValue en ui_form

**Archivos afectados:** `data/flows.json` (todos los nodos `ui_form`)

### Problema

`node-red-dashboard v2` requiere que `formValue` sea un **objeto** `{}`. Todos los formularios tenían `"formValue": []` (array vacío), lo que causaba que al hacer submit el payload se emitiera como array vacío en lugar del objeto con los campos del formulario.

### Síntoma

Al registrar un usuario, la tabla mostraba `undefined undefined` en Nombre Completo, y el sistema lanzaba `❌ El usuario "undefined" ya existe`.

### Solución

Reemplazar `"formValue": []` → `"formValue": {}` en los 12 formularios del flujo.

---

## P6 — Guardas null-check en function handlers

**Archivos afectados:** todos los nodos `function` conectados a `ui_form`

### Problema

En `node-red-dashboard v2`, el botón **"Limpiar"** (cancel) y las reconexiones del dashboard emiten mensajes al flow con `msg.payload = null`. Sin validación, los handlers corrían igual y guardaban registros con todos los campos `undefined`.

### Solución

Se agregó la siguiente guarda al inicio de cada handler, verificando los campos requeridos específicos de cada formulario:

```javascript
if (!msg.payload || typeof msg.payload !== 'object' || !msg.payload.<campo_requerido>) { return null; }
```

| Handler | Campo(s) verificados |
|---|---|
| `fn-guardar-usuario` | `usuario` |
| `fn-guardar-agrocadena` | `nombre` |
| `fn-guardar-etapa` | `nombre`, `agrocadena_id` |
| `fn-guardar-rol` | `nombre` |
| `fn-guardar-permiso` | `nombre` |
| `fn-asignar-rol` | `usuario_id`, `rol_id` |
| `fn-cambiar-estado-usuario` | `usuario_id`, `estado` |
| `fn-asignar-permiso-rol` | `rol_id`, `permiso_id` |
| `fn-guardar-modulo` | `nombre` |
| `fn-guardar-pagina` | `nombre`, `ruta` |
| `fn-guardar-opcion` | `pagina_id`, `nombre` |
| `fn-add-catalogo` (reemplazado en P8) | `catalogo`, `valor` |

---

## P7 — Validación de duplicados en Rol y validación dinámica de TipoUsuario

### P7a — Duplicados en fn-guardar-rol

`fn-guardar-rol` no tenía validación de duplicados. Se agregó búsqueda case-insensitive antes de insertar. Además se corrigió que los roles creados manualmente no incluían `permisos: []`.

```javascript
var existe = lista.find(function(r){ return r.nombre.toLowerCase() === msg.payload.nombre.toLowerCase(); });
if (existe) { msg.payload = '❌ El rol "' + msg.payload.nombre + '" ya existe'; return msg; }
var nuevo = {id: ..., nombre: ..., fecha_creacion: ..., permisos: []};
```

### P7b — Validación dinámica de TipoUsuario en fn-guardar-usuario

El campo "Tipo de Usuario" del formulario de registro es texto libre (limitación de `ui_form` v2 — no soporta dropdowns dinámicos). Se agregó validación en `fn-guardar-usuario` contra el catálogo `tiposUsuario` en el storage global:

```javascript
var tiposUsuario = global.get('tiposUsuario') || [];
var tipoValido = tiposUsuario.find(function(t){
    var nombre = typeof t === 'object' ? t.nombre : t;
    return nombre.toLowerCase() === msg.payload.tipo_usuario.toLowerCase();
});
if (!tipoValido) { msg.payload = '❌ Tipo de usuario "' + msg.payload.tipo_usuario + '" no válido. Use: ...'; return msg; }
```

Esto conecta funcionalmente el catálogo `tiposUsuario` con el registro de usuarios: cualquier tipo agregado en Tablas Maestro queda disponible automáticamente para el registro.

---

## P8 — Refactor completo del Tab Tablas Maestro

**Motivación:** el modelo de dominio define entidades independientes (`TipoUsuario`, `TipoParticipante`, `TipoProyección`, `TipoReporte`, `TablaMaestro`). La implementación anterior los agrupaba en una sola vista genérica con un formulario de texto libre que requería escribir el nombre del catálogo manualmente.

### Estructura anterior

Un único `ui-group-maestro` con:
- 4 `ui_text` para mostrar listas separadas por coma
- 1 botón "Cargar Catálogos"
- 1 formulario genérico con campos `catalogo` + `valor`
- `tiposParticipante`, `tiposProyeccion`, `tiposReporte` almacenados como arrays de strings

### Estructura nueva

4 secciones independientes, cada una con su propio `ui_group`, formulario, tabla y botón de refresco:

#### Tipos de Usuario (`ui-group-tipos-usuario`)

| Nodo | Tipo | Descripción |
|---|---|---|
| `form-tipo-usuario` | `ui_form` | Campo: Nombre |
| `fn-guardar-tipo-usuario` | `function` | Valida duplicados, guarda `{id, nombre}` en `tiposUsuario` |
| `fn-refrescar-tipos-usuario` | `function` | Prepara array para tabla |
| `tabla-tipos-usuario` | `ui_table` | Columnas: ID, Nombre |
| `btn-refrescar-tipos-usuario` | `ui_button` | Refresco manual |

#### Tipos de Participante (`ui-group-tipos-participante`)

Implementa **todos los atributos** del modelo de dominio:

| Nodo | Tipo | Descripción |
|---|---|---|
| `form-tipo-participante` | `ui_form` | Campos: Nombre, Dirección, Teléfono, Tipo Documento, Identificación, Tipo Participante, Estado |
| `fn-guardar-tipo-participante` | `function` | Valida duplicado por `identificacion`, valida estado `Activo/Inactivo` |
| `fn-refrescar-tipos-participante` | `function` | Prepara array para tabla |
| `tabla-tipos-participante` | `ui_table` | Columnas: ID, Nombre, Tipo Doc, Identificación, Tipo Part., Teléfono, Estado |
| `btn-refrescar-tipos-participante` | `ui_button` | Refresco manual |

Estructura en storage:
```json
{
  "id": "1234567890",
  "nombre": "Productor",
  "direccion": "Calle 10 #5-20",
  "telefono": "3001234567",
  "tipo_documento": "NIT",
  "identificacion": "900123456",
  "tipo_participante": "Primario",
  "estado": "Activo"
}
```

#### Tipos de Proyección (`ui-group-tipos-proyeccion`)

| Nodo | Tipo | Descripción |
|---|---|---|
| `form-tipo-proyeccion` | `ui_form` | Campo: Nombre |
| `fn-guardar-tipo-proyeccion` | `function` | Valida duplicados, guarda `{id, nombre}` |
| `fn-refrescar-tipos-proyeccion` | `function` | Prepara array para tabla |
| `tabla-tipos-proyeccion` | `ui_table` | Columnas: ID, Nombre |

#### Tipos de Reporte (`ui-group-tipos-reporte`)

| Nodo | Tipo | Descripción |
|---|---|---|
| `form-tipo-reporte` | `ui_form` | Campo: Nombre |
| `fn-guardar-tipo-reporte` | `function` | Valida duplicados, guarda `{id, nombre}` |
| `fn-refrescar-tipos-reporte` | `function` | Prepara array para tabla |
| `tabla-tipos-reporte` | `ui_table` | Columnas: ID, Nombre |

### Migración del init-storage

Los catálogos `tiposParticipante`, `tiposProyeccion` y `tiposReporte` en `fn-init-storage` se migraron de arrays de strings a arrays de objetos `{id, nombre}` (o con atributos completos para TipoParticipante), alineándose al mismo patrón de `TipoUsuario`.

### Auto-carga

Se agregó un nodo `inject-maestro-init` con `once: true` y delay de 1.5s que dispara automáticamente la carga de las 4 tablas al iniciar el contenedor.

---

## Estado del módulo ADM tras la implementación

| Entidad | Estado |
|---|---|
| `TipoUsuario` | ✅ Entidad `{id, nombre}` — CRUD completo con tabla |
| `TipoParticipante` | ✅ Entidad completa con todos los atributos del modelo — CRUD con tabla |
| `TipoProyección` | ✅ Entidad `{id, nombre}` — CRUD completo con tabla |
| `TipoReporte` | ✅ Entidad `{id, nombre}` — CRUD completo con tabla |
| `TablaMaestro` | ✅ Implementada como 4 secciones independientes en tab Maestro |
| `Usuario` | ✅ CRUD completo + asignación de rol + cambio de estado + validación dinámica de tipo |
| `Rol → Admin / Invitado` | ✅ CRUD + permisos asignados visibles en tabla + validación duplicados |
| `Permiso` | ✅ CRUD completo con UI |
| Asignación Rol → Permiso | ✅ Formulario + lógica de asignación |
| Asignación Usuario → Rol | ✅ Formulario + lógica de asignación |
| `Modulo` | ✅ CRUD completo |
| `Pagina` | ✅ CRUD completo |
| `Opcion` (composición con Pagina) | ✅ Agregar opciones a páginas por ID |

---

## Notas técnicas

- **Almacenamiento**: todo usa `global.set/get` de Node-RED (memoria en RAM del contenedor). Los datos se pierden si el contenedor se reinicia. Para producción se recomienda migrar a MySQL/PostgreSQL.
- **IDs**: se generan con `Date.now().toString()` — suficiente para desarrollo; en producción usar UUID.
- **Limitación de ui_form v2**: no soporta campos dropdown dinámicos. Los campos de selección (tipo_usuario, tipo_participante, estado) son texto libre validado en el backend del flow.
- **Para resetear el storage**: reiniciar el contenedor con `docker compose restart` limpia la memoria y vuelve a inicializar los valores por defecto.
