# Node-RED Project

## Requirements
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Start

```bash
docker compose up -d
```

Node-RED will be available at http://localhost:1880

## Stop

```bash
docker compose down
```

## Flows

Flows are saved to `./data/flows.json` and tracked by git.  
After making changes in the Node-RED UI, commit and push `data/flows.json`.

> **Never commit** `flows_cred.json` — it contains sensitive credentials.
