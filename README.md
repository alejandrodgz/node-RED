# Node-RED Project

## Requirements
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Start

Primera vez (o después de cambiar `Dockerfile`/`package.json`):
```bash
docker compose up --build -d
```

Usos siguientes:
```bash
docker compose up -d
```

| URL | Descripción |
|---|---|
| http://localhost:1880 | Editor de Node-RED |
| http://localhost:1880/ui | Dashboard (UI pública) |

## Stop

```bash
docker compose down
```

## Agregar módulos

Edita el `Dockerfile` y agrega el módulo al comando `npm install`, luego reconstruye:
```bash
docker compose up --build -d
```

## Flows

Flows se guardan en `./data/flows.json` y se trackean con git.  
Después de hacer cambios en la UI, commitear y pushear `data/flows.json`.

> **Nunca commitear** `flows_cred.json` — contiene credenciales sensibles.
