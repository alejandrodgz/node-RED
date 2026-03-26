# Modelo de Dominio — Evergreen · Módulo ADM

```mermaid
classDiagram
    direction TB

    %% ── GESTIÓN DE USUARIOS ──────────────────────────────
    class TipoUsuario {
        +id : int
        +nombre : string
    }

    class Usuario {
        +id : int
        +usuario : string
        +nombre : string
        +apellido : string
        +clave : string
        +estado : boolean
        +fecha_registro : date
    }

    %% ── CONTROL DE ACCESO ────────────────────────────────
    class Rol {
        <<abstract>>
        +id : int
        +nombre : string
        +fecha_creacion : date
    }

    class Admin {
    }

    class Invitado {
    }

    class Permiso {
        +id : int
        +nombre : string
        +fecha_creacion : date
    }

    %% ── NAVEGACIÓN ───────────────────────────────────────
    class Pagina {
        +id : int
        +nombre : string
        +ruta : string
    }

    class Opcion {
        +id : int
        +nombre : string
        +URL : string
    }

    class Modulo {
        +id : int
        +nombre : string
    }

    %% ── AGROCADENA ───────────────────────────────────────
    class AgroCadena {
        +id : int
        +nombre : string
        +descripcion : string
    }

    class Etapa {
        +id : int
        +nombre : string
        +descripcion : string
    }

    class TipoParticipante {
        +id : int
        +nombre : string
        +tipo_documento : string
        +identificacion : string
        +estado : boolean
    }

    %% ── TABLAS MAESTRO ───────────────────────────────────
    class TablaMaestro {
        +id : int
        +nombre : string
    }

    %% ── RELACIONES ───────────────────────────────────────

    %% Herencia
    Rol <|-- Admin
    Rol <|-- Invitado

    %% Composición (el hijo no existe sin el padre)
    AgroCadena *-- Etapa : contiene
    Pagina *-- Opcion : contiene

    %% Asociaciones
    TipoUsuario --> Usuario : clasifica
    Usuario --> Rol : tiene asignado
    Rol --> Permiso : otorga
    Invitado --> Opcion : puede acceder a
    Opcion --> Modulo : pertenece a
    Modulo --> TablaMaestro : referencia
    Etapa --> TipoParticipante : involucra
```

## Leyenda

| Símbolo | Tipo | Significado |
|---|---|---|
| `*--` | Composición | El hijo no existe sin el padre |
| `<\|--` | Herencia | El hijo es un tipo del padre |
| `-->` | Asociación | Una entidad conoce / referencia a otra |

## Módulos del sistema

| Módulo | Entidades principales |
|---|---|
| **Gestión de Usuarios** | TipoUsuario, Usuario |
| **Control de Acceso** | Rol, Admin, Invitado, Permiso |
| **Navegación** | Pagina, Opcion, Modulo |
| **AgroCadena** | AgroCadena, Etapa, TipoParticipante |
| **Tablas Maestro** | TablaMaestro, TipoProyeccion, TipoReporte |
