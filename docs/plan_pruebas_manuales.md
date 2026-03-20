# Plan de Pruebas Manuales — Módulo ADM (Node-RED / Evergreen)

**URL Dashboard:** http://localhost:1880/ui  
**URL Editor:** http://localhost:1880  

---

## Preparación

Antes de iniciar, asegúrate de que el contenedor esté corriendo:

```bash
docker compose up -d
```

> **Nota:** El almacenamiento es en memoria. Cada vez que se reinicia el contenedor, los datos se pierden. El nodo `init-storage` carga datos iniciales automáticamente al arrancar.

---

## PASO 1 — Tab: Control de Acceso (Roles y Permisos)

> Empezar aquí porque Usuarios depende de Roles y Permisos.

### 1.1 Verificar datos iniciales

1. Ir al tab **Control de Acceso** en el dashboard.
2. Hacer clic en **🔄 Refrescar** (sección Roles).
3. ✅ Debe aparecer la tabla con 2 roles pre-cargados: `Admin` e `Invitado`.
4. Hacer clic en **🔄 Refrescar** (sección Permisos).
5. ✅ Debe aparecer la tabla con 3 permisos: `Ver`, `Editar`, `Eliminar`.

### 1.2 Crear un nuevo Rol

| Campo | Valor de prueba |
|---|---|
| Nombre del Rol | `Supervisor` |

1. Llenar el formulario **Crear Rol** con `Supervisor`.
2. Hacer clic en **Crear Rol**.
3. ✅ Toast: `✅ Rol "Supervisor" creado`.
4. Refrescar tabla de roles.
5. ✅ El rol `Supervisor` aparece en la tabla con su ID y fecha.

### 1.3 Crear un nuevo Permiso

| Campo | Valor de prueba |
|---|---|
| Nombre del Permiso | `Exportar` |

1. Llenar el formulario **Crear Permiso** con `Exportar`.
2. Hacer clic en **Crear Permiso**.
3. ✅ Toast: `✅ Permiso "Exportar" creado con ID <id>`.
4. Refrescar tabla de permisos.
5. ✅ El permiso `Exportar` aparece.

### 1.4 Asignar Permiso a Rol

> Usar los IDs que aparecen en las tablas.

| Campo | Valor |
|---|---|
| ID del Rol | `1` (Admin) |
| ID del Permiso | `1` (Ver) |

1. Llenar el formulario **Asignar Permiso a Rol**.
2. Hacer clic en **Asignar**.
3. ✅ Toast de éxito.
4. Refrescar tabla de roles.
5. ✅ La columna `Permisos` del rol `Admin` muestra `Ver`.

### 1.5 Pruebas de error esperadas

| Acción | Error esperado |
|---|---|
| Crear rol con nombre `Admin` (ya existe como dato inicial) | `❌ El rol "Admin" ya existe` |
| Asignar permiso con ID de rol inexistente (`999`) | `❌ No se encontró rol con ID 999` |
| Asignar el mismo permiso dos veces al mismo rol | `❌ El permiso "Ver" ya está asignado al rol "Admin"` |

---

## PASO 2 — Tab: Tablas Maestro (Catálogos)

### 2.1 Cargar catálogos

1. Ir al tab **Tablas Maestro**.
2. Hacer clic en **🔄 Cargar Catálogos**.
3. ✅ Deben aparecer los valores en cada sección:
   - **Tipos de Usuario:** Administrador, Operador, Invitado
   - **Tipos de Participante:** (lista inicial)
   - **Tipos de Proyección:** (lista inicial)
   - **Tipos de Reporte:** (lista inicial)

### 2.2 Agregar valor a catálogo

| Campo | Valor |
|---|---|
| Catálogo | `tiposUsuario` |
| Valor | `Auditor` |

1. Llenar el formulario **Agregar Valor a Catálogo**.
2. Hacer clic en **Agregar**.
3. ✅ Toast de éxito.
4. Recargar catálogos.
5. ✅ `Auditor` aparece en la lista Tipos de Usuario.

### 2.3 Pruebas de error esperadas

| Acción | Error esperado |
|---|---|
| Catálogo con nombre inválido (`otrosCatalogos`) | `❌ Catálogo no válido. Use: tiposUsuario, ...` |
| Agregar `Auditor` nuevamente | `❌ "Auditor" ya existe en tiposUsuario` |

---

## PASO 3 — Tab: Módulos

### 3.1 Crear un Módulo

| Campo | Valor |
|---|---|
| Nombre del Módulo | `ADM` |

1. Hacer clic en **🔄 Refrescar** para ver el estado actual.
2. Llenar el formulario **Registrar Módulo** con `ADM`.
3. Hacer clic en **Registrar**.
4. ✅ Toast: `✅ Módulo "ADM" creado con ID <id>`.
5. Refrescar tabla de módulos.
6. ✅ `ADM` aparece en la tabla. **Anotar el ID**.

### 3.2 Crear una Página

| Campo | Valor |
|---|---|
| Nombre de la Página | `Gestión de Usuarios` |
| Ruta | `/usuarios` |

1. Llenar el formulario **Registrar Página**.
2. Hacer clic en **Registrar Página**.
3. ✅ Toast de éxito. **Anotar el ID de la página**.
4. Refrescar tabla de páginas.
5. ✅ Aparece con `Opciones: 0`.

### 3.3 Agregar una Opción a la Página

| Campo | Valor |
|---|---|
| ID de la Página | `<id anotado arriba>` |
| Nombre de la Opción | `Listar Usuarios` |
| URL | `/usuarios/listado` |
| ID del Módulo (opcional) | `<id del módulo ADM>` |

1. Llenar el formulario **Agregar Opción a Página**.
2. Hacer clic en **Agregar Opción**.
3. ✅ Toast: `✅ Opción "Listar Usuarios" agregada a la página "Gestión de Usuarios"`.
4. Refrescar tabla de páginas.
5. ✅ La página ahora muestra `Opciones: 1`.

### 3.4 Pruebas de error esperadas

| Acción | Error esperado |
|---|---|
| Crear módulo `ADM` nuevamente | `❌ El módulo "ADM" ya existe` |
| Crear página con ruta `/usuarios` nuevamente | `❌ Ya existe una página con ruta "/usuarios"` |
| Agregar opción con ID de página inexistente | `❌ No se encontró página con ID <id>` |

---

## PASO 4 — Tab: Usuarios

### 4.1 Crear un Usuario

| Campo | Valor |
|---|---|
| Usuario (login) | `jquintero` |
| Nombre | `Juan` |
| Apellido | `Quintero` |
| Tipo de Usuario | `Administrador` |
| Contraseña | `pass123` |

1. Llenar el formulario **Registrar Usuario**.
2. Hacer clic en **Registrar**.
3. ✅ Toast: `✅ Usuario "jquintero" registrado correctamente`.
4. Hacer clic en **🔄 Refrescar** (Lista de Usuarios).
5. ✅ El usuario aparece con estado `Activo` y Rol `-`.

Crear un segundo usuario:

| Campo | Valor |
|---|---|
| Usuario (login) | `sortiz` |
| Nombre | `Simon` |
| Apellido | `Ortiz` |
| Tipo de Usuario | `Operador` |
| Contraseña | `pass456` |

### 4.2 Asignar Rol a Usuario

> Usar el ID del usuario que aparece en la tabla y el ID del rol de la tabla de Control de Acceso.

| Campo | Valor |
|---|---|
| ID del Usuario | `<id de jquintero>` |
| ID del Rol | `1` (Admin) |

1. Llenar el formulario **Asignar Rol a Usuario**.
2. Hacer clic en **Asignar**.
3. ✅ Toast de éxito.
4. Refrescar tabla de usuarios.
5. ✅ `jquintero` ahora muestra `Admin` en la columna Rol.

### 4.3 Cambiar Estado de Usuario

| Campo | Valor |
|---|---|
| ID del Usuario | `<id de sortiz>` |
| Nuevo Estado | `Inactivo` |

1. Llenar el formulario **Cambiar Estado de Usuario**.
2. Hacer clic en **Actualizar Estado**.
3. ✅ Toast: `✅ Estado de "sortiz" cambiado de Activo a Inactivo`.
4. Refrescar tabla.
5. ✅ `sortiz` muestra estado `Inactivo`.

### 4.4 Pruebas de error esperadas

| Acción | Error esperado |
|---|---|
| Registrar usuario con login `jquintero` nuevamente | `❌ El usuario "jquintero" ya existe` |
| Asignar rol con ID de usuario inexistente | `❌ No se encontró usuario con ID <id>` |
| Cambiar estado a `Suspendido` (no válido) | `❌ Estado no válido. Use: Activo o Inactivo` |

---

## PASO 5 — Tab: AgroCadenas

### 5.1 Crear una AgroCadena

| Campo | Valor |
|---|---|
| Nombre | `Cadena Café` |
| Descripción | `Cadena agroalimentaria del café colombiano` |
| Estado | `Activo` |

1. Llenar el formulario **Registrar AgroCadena**.
2. Hacer clic en **Registrar**.
3. ✅ Toast de éxito. **Anotar el ID**.
4. Refrescar tabla.
5. ✅ Aparece con `Etapas: 0`.

### 5.2 Agregar Etapa a AgroCadena

| Campo | Valor |
|---|---|
| ID de la AgroCadena | `<id anotado>` |
| Nombre de la Etapa | `Cosecha` |
| Descripción | `Recolección del grano` |

1. Llenar el formulario **Agregar Etapa a AgroCadena**.
2. Hacer clic en **Agregar Etapa**.
3. ✅ Toast: `✅ Etapa "Cosecha" agregada a "Cadena Café"`.
4. Refrescar tabla de AgroCadenas.
5. ✅ `Cadena Café` muestra `Etapas: 1`.

---

## Resumen de verificación final

| Tab | Estado |
|---|---|
| Control de Acceso — Roles | ✅ |
| Control de Acceso — Permisos | ✅ |
| Control de Acceso — Asignación | ✅ |
| Tablas Maestro — Carga inicial | ☐ |
| Tablas Maestro — Agregar valor | ☐ |
| Módulos — Crear módulo | ☐ |
| Módulos — Crear página | ☐ |
| Módulos — Agregar opción | ☐ |
| Usuarios — Registrar | ☐ |
| Usuarios — Asignar rol | ☐ |
| Usuarios — Cambiar estado | ☐ |
| AgroCadenas — Registrar | ☐ |
| AgroCadenas — Agregar etapa | ☐ |

