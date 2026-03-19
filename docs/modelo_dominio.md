# Modelo de Dominio — Evergreen

```mermaid
classDiagram
    direction TB

    class TipoUsuario {
    }

    class Usuario {
        +id
        +usuario
        +nombre
        +apellido
        +tipo_usuario
        +clave
        +hora_registro
        +fecha_registro
        +estado
    }

    class Rol {
        <<abstract>>
    }

    class Admin {
        +id
        +nombre
        +fecha_de_creacion
    }

    class Invitado {
        +id
        +nombre
        +fecha_de_creacion
    }

    class Permiso {
        +id
        +nombre
        +fecha_creacion
    }

    class Pagina {
        +id
        +nombre
        +ruta
    }

    class Opcion {
        +id
        +nombre
        +URL
    }

    class Modulo {
    }

    class TablaMaestro {
    }

    class AgroCadena {
        +method()
    }

    class Etapas {
        +method()
    }

    class TipoParticipante {
        +id
        +nombre
        +direccion
        +telefono
        +tipo_documento
        +identificacion
        +tipo_participante
        +estado
    }

    class TipoProyeccion {
    }

    class TipoReporte {
    }

    %% Herencia
    Rol <|-- Admin
    Rol <|-- Invitado

    %% Asociaciones
    TipoUsuario --> Usuario : clasifica
    Usuario --> Rol : tiene
    Rol --> Permiso : tiene
    Invitado --> Opcion : accede a
    Opcion --> Modulo : pertenece a
    Modulo --> TablaMaestro : referencia
    Etapas --> TipoParticipante : involucra

    %% Composición
    AgroCadena *-- Etapas : contiene
    Pagina *-- Opcion : contiene
```

## Leyenda

| Símbolo | Tipo | Significado |
|---|---|---|
| `*--` | Composición | El hijo no existe sin el padre |
| `<\|--` | Herencia | El hijo es un tipo del padre |
| `-->` | Asociación | Una entidad conoce/referencia a otra |
