# Diagrama de Clases UML — Evergreen · Módulo ADM

```mermaid
classDiagram
    direction TB

    %% ── GESTIÓN DE USUARIOS ──────────────────────────────

    class TipoUsuario {
        +id : int
        +nombre : string
        +getNombre() string
    }

    class Usuario {
        +id : int
        +usuario : string
        +nombre : string
        +apellido : string
        -clave : string
        +tipo_usuario : int
        +estado : boolean
        +fecha_registro : date
        +hora_registro : time
        +registrar() void
        +actualizar() void
        +desactivar() void
    }

    %% ── CONTROL DE ACCESO ────────────────────────────────

    class Rol {
        <<abstract>>
        +id : int
        +nombre : string
        +fecha_creacion : date
        +getNombre() string
        +getPermisos() Permiso[]
    }

    class Admin {
        +crearUsuario() void
        +eliminarUsuario() void
        +asignarRol() void
    }

    class Invitado {
        +consultarOpciones() Opcion[]
    }

    class Permiso {
        +id : int
        +nombre : string
        +fecha_creacion : date
        +opcion_ids : string[]
        +getNombre() string
    }

    %% ── NAVEGACIÓN ───────────────────────────────────────

    class Pagina {
        +id : int
        +nombre : string
        +ruta : string
        +getOpciones() Opcion[]
    }

    class Opcion {
        +id : int
        +nombre : string
        +URL : string
        +getURL() string
    }

    class Modulo {
        +id : int
        +nombre : string
        +getOpciones() Opcion[]
    }

    %% ── AGROCADENA ───────────────────────────────────────

    class AgroCadena {
        +id : int
        +nombre : string
        +descripcion : string
        +estado : string
        +registrar() void
        +agregarEtapa(etapa : Etapa) void
        +getEtapas() Etapa[]
    }

    class Etapa {
        +id : int
        +nombre : string
        +descripcion : string
        +registrar() void
        +getParticipantes() TipoParticipante[]
    }

    class TipoParticipante {
        +id : int
        +nombre : string
        +tipo_documento : string
        +identificacion : string
        +estado : boolean
        +getNombre() string
    }

    %% ── TABLAS MAESTRO ───────────────────────────────────

    class TablaMaestro {
        +id : int
        +nombre : string
        +getNombre() string
    }

    %% ── RELACIONES ───────────────────────────────────────

    %% Herencia
    Rol <|-- Admin
    Rol <|-- Invitado

    %% Composición (el hijo no existe sin el padre)
    AgroCadena "1" *-- "1..*" Etapa : contiene
    Pagina "1" *-- "1..*" Opcion : contiene

    %% Asociaciones con multiplicidad
    TipoUsuario "1" --> "0..*" Usuario : clasifica
    Usuario "0..*" --> "1" Rol : tiene asignado
    Rol "1" --> "0..*" Permiso : otorga
    Permiso "0..*" --> "0..*" Opcion : habilita acceso a
    Modulo "1" --> "0..*" Pagina : agrupa
    Opcion "0..*" --> "1" Modulo : pertenece a
    Modulo "0..*" --> "0..*" TablaMaestro : referencia
    Etapa "0..*" --> "0..*" TipoParticipante : involucra
```

## Leyenda de relaciones

| Símbolo | Tipo | Lectura |
|---|---|---|
| `<\|--` | Herencia (generalización) | "es un tipo de" |
| `"1" *-- "1..*"` | Composición | El hijo no puede existir sin el padre |
| `"1" --> "0..*"` | Asociación | Una instancia se relaciona con cero o más |
| `"0..*" --> "0..*"` | Asociación muchos a muchos | Varias instancias se relacionan entre sí |

## Multiplicidades utilizadas

| Notación | Significado |
|---|---|
| `1` | Exactamente uno |
| `0..*` | Cero o muchos |
| `1..*` | Uno o muchos (al menos uno) |

## Notas de diseño

- **`Rol`** es abstracta — no se instancia directamente, solo a través de `Admin` o `Invitado`.
- **`Permiso`** media el acceso a `Opcion`: un Invitado llega a las opciones *a través* de los permisos que tenga asignados su rol, no directamente.
- **`Permiso`** media el acceso a `Opcion`: un Invitado llega a las opciones *a través* de los permisos que tenga asignados su rol, no directamente.
- **`Permiso.opcion_ids`** modela en la implementación la lista de opciones habilitadas por permiso.
- **`Modulo`** agrupa `Pagina` en la implementación (`pagina.modulo_id`) y cada `Opcion` queda asociada al módulo de su página.
- **`clave`** en `Usuario` tiene visibilidad privada (`-`) — no se expone en consultas ni en la UI.
- **`Etapa`** tiene composición con `AgroCadena` — si se elimina la cadena, sus etapas desaparecen.
- **`Opcion`** tiene composición con `Pagina` — una opción no existe fuera de su página.
- **`TablaMaestro`** agrupa los catálogos del sistema: TipoUsuario, TipoParticipante, TipoProyección, TipoReporte.
