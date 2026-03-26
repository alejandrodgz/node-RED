# Plan Entrega 2 — Node-RED · Equipo ADM

---

## Prioridad 1 — Correcciones del informe (feedback Entrega 1)

Estos puntos deben quedar resueltos antes de agregar contenido nuevo.

| # | Ítem a corregir | Qué hacer | Quién |
|---|---|---|---|
| C1 | Referencias | Agregar sección de referencias con formato APA. Mínimo 5 fuentes (sitio oficial, npm, docs, artículos). | Todos |
| C2 | 2.1 / 2.2 — Proceso | Insertar diagrama gráfico del flujo de desarrollo (canva.png ya existe en docs/). | Simon |
| C3 | 2.3 / 2.4 — Orígenes y controles | Insertar diagrama de clases del modelo de dominio ADM (ver `modelo_dominio.md`). | Simon |
| C4 | Sección 3 — Evaluación | Agregar tabla resumen con calificación (Alto / Medio / Bajo) para cada característica evaluada. | Juan Esteban |
| C5 | Sección 4 — Conclusiones | Reescribir conclusiones como lista con estructura: hallazgo → implicación. | Daniel |
| C6 | Designación de tareas | Agregar tabla con horas de uso planeadas por integrante (H de U). | Todos |

---

## Prioridad 2 — Nuevas secciones (exclusivas de Entrega 2)

### 2.5 Aplicación en el Caso de Estudio

Describir qué se construyó en Node-RED para el módulo ADM de Evergreen:

- Explicar el flujo general de la aplicación (usuarios, roles, validaciones)
- Nombrar los flows implementados y su propósito
- Incluir captura del canvas de Node-RED con los flows activos
- Relacionar cada flow con su entidad del modelo de dominio

### 2.6 Uso de DSLs en la Herramienta

- Explicar que Node-RED es un **DSL visual** basado en grafos de nodos
- El nodo `function` actúa como DSL imperativo embebido (JavaScript)
- Mostrar ejemplo de un nodo function usado en el proyecto (validación de correo o login)
- Comparar: flujo visual (declarativo) vs. nodo function (imperativo)

### 2.7 Resultados Obtenidos

- Captura de cada historia de usuario ejecutándose en el Dashboard (`localhost:1880/ui`)
- Tabla de resultados: HU → entrada de prueba → resultado esperado → resultado obtenido
- Análisis de si el comportamiento es correcto y qué limitaciones encontraron

---

## Prioridad 3 — Implementación en Node-RED

Cada integrante implementa y documenta una historia de usuario en el módulo ADM.

### HU1 — Registro de AgroCadena · *Simon Ortiz*

**Como** usuario del sistema Evergreen, **quiero** registrar una nueva AgroCadena junto con sus etapas productivas **para** tener un registro centralizado de las cadenas agroalimentarias activas y poder consultarlas en cualquier momento.

Flow existente: **Tab AgroCadenas**

Flujo Node-RED:
```
[ui_form: nombre + descripción + estado]
  → [function: guardar AgroCadena en global.agrocadenas]
    → [ui_toast: confirmación de registro]
    → [function: preparar tabla] → [ui_table: lista de AgroCadenas]

[ui_form: etapa + AgroCadena ID]
  → [function: agregar etapa a la AgroCadena correspondiente]
    → [ui_toast: confirmación de etapa]
```

Criterios de aceptación:
- Ingresar nombre y descripción → la AgroCadena aparece en la tabla con un ID generado automáticamente
- Agregar una etapa a una AgroCadena existente → la etapa queda asociada a esa cadena
- Intentar registrar sin nombre → el sistema no guarda y no muestra notificación de éxito
- La tabla se actualiza automáticamente tras cada registro sin recargar la página

---

### HU2 — Registro y consulta de usuarios · *Juan Esteban Quintero*

**Como** usuario del sistema Evergreen, **quiero** registrar nuevos usuarios con su información básica y tipo **para** mantener un directorio actualizado de las personas que tienen acceso al sistema y poder consultarlo en cualquier momento.

Flow existente: **Tab Usuarios**

Flujo Node-RED:
```
[ui_form: nombre + apellido + usuario + clave + tipo_usuario + estado]
  → [function: validar duplicado por nombre de usuario]
    → [ui_toast: confirmación o error de duplicado]
    → [function: preparar tabla] → [ui_table: lista de usuarios]
```

Criterios de aceptación:
- Registrar un usuario con todos los campos → aparece en la tabla con fecha de registro
- Intentar registrar un usuario con el mismo nombre de usuario → el sistema muestra error "usuario ya existe"
- El campo clave se guarda pero no se muestra en la tabla (privacidad)
- La lista de tipos de usuario se carga desde los catálogos de Tablas Maestro

---

### HU3 — Asignación de roles y permisos · *Daniel Garcia*

**Como** usuario del sistema Evergreen, **quiero** crear roles, definirles permisos y asignarlos a los usuarios registrados **para** controlar qué acciones puede realizar cada persona dentro del sistema.

Flow existente: **Tab Control de Acceso**

Flujo Node-RED:
```
[ui_form: nombre del rol]
  → [function: guardar rol en global.roles] → [ui_toast: confirmación]

[ui_form: rol_id + permiso_id]
  → [function: asignar permiso al rol, validar duplicado]
    → [ui_toast: confirmación o error]

[ui_table: lista de roles con permisos asignados]
```

Criterios de aceptación:
- Crear un rol nuevo → aparece en la tabla de roles
- Asignar un permiso a un rol → el rol muestra el permiso en su registro
- Intentar asignar el mismo permiso dos veces al mismo rol → el sistema muestra error "ya asignado"
- Los roles Admin e Invitado vienen precargados al iniciar el sistema

---

## Prioridad 4 — Presentación (PowerPoint)

Estructura sugerida (basada en los numerales del informe):

| Diapositiva | Contenido |
|---|---|
| 1 | Portada — Herramienta: Node-RED · Módulo: ADM |
| 2 | 1.1 Presentación — logo, versión, descripción |
| 3 | 1.2 Arquitectura — diagrama Editor + Runtime |
| 4 | 1.3 Plataforma — Node.js, multiplataforma, Docker |
| 5 | 2.1 / 2.2 Instalación y Montaje — pasos + canva.png |
| 6 | 2.3 / 2.4 Orígenes y Nodos — tabla + diagrama de clases |
| 7 | 2.5 Caso de Estudio — flows ADM + captura |
| 8 | 2.6 DSL — flujo visual vs. function node |
| 9 | 2.7 Resultados — tabla de pruebas + capturas |
| 10 | 3 — Evaluación — tabla resumen de calificación |
| 11 | 4 — Conclusiones — lista esquematizada |
| 12 | Referencias + HU por integrante con H de U |

---

## Cronograma sugerido

| Fase | Tareas | Responsable |
|---|---|---|
| Semana 1 | C1–C6: corregir informe Entrega 1 | Todos según columna |
| Semana 1 | Implementar HU1, HU2, HU3 en Node-RED | Cada uno su HU |
| Semana 2 | Escribir secciones 2.5, 2.6, 2.7 | Simon coordina |
| Semana 2 | Tomar capturas de cada HU funcionando | Cada uno |
| Semana 2 | Armar presentación PowerPoint | Daniel / Juan Esteban |
| Cierre | Revisión final del informe + referencias | Todos |

---

## Checklist final antes de entregar

- [ ] Referencias en formato APA (mínimo 5)
- [ ] Diagrama de proceso en 2.2
- [ ] Diagrama de clases ADM en 2.3
- [ ] Tabla de evaluación en sección 3
- [ ] Conclusiones esquematizadas en sección 4
- [ ] Tabla de H de U por integrante
- [ ] Secciones 2.5, 2.6, 2.7 completas
- [ ] Capturas de los 3 flows en el Dashboard
- [ ] Presentación PowerPoint lista
- [ ] `flows.json` actualizado y pusheado al repo
