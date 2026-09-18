# Exercício — Docker Compose

## Objetivo

Subir a `task-api` **e** um Redis juntos via Compose, e confirmar que a API troca de
armazenamento em memória para o Redis sem nenhuma mudança de código — só de configuração.

A aplicação já sabe fazer isso: se a variável de ambiente `REDIS_URL` existir, ela guarda as
tarefas no Redis; senão, usa a lista em memória de antes (ver `apps/task-api/app.py`).

> No macOS, a porta 5000 do host colide com o AirPlay Receiver (mesmo aviso da Aula 02) — se
> `curl localhost:5000/...` retornar `403`, mapeie `"5050:5000"` no `docker-compose.yml` em vez
> de `"5000:5000"`.

## Passo a passo

1. Crie `docker-compose.yml` em `apps/task-api/` com dois serviços: `api` (build a partir do
   `Dockerfile` da Aula 02) e `cache` (`redis:7-alpine`, com volume nomeado).
2. Configure `REDIS_URL=redis://cache:6379/0` no serviço `api`.
3. Suba: `docker compose up -d --build`.
4. Crie uma tarefa: `curl -X POST localhost:5000/tasks -d '{"title":"via compose"}' -H
   'Content-Type: application/json'`.
5. Prove que ela está no Redis, não em memória: `docker compose restart api`, depois `curl
   localhost:5000/tasks` de novo — se a tarefa **sobreviveu** ao restart, está no Redis (o
   armazenamento em memória perderia tudo).
6. Compare: pare também o `cache` (`docker compose stop cache && docker compose start cache`)
   — a tarefa sobrevive? Por quê (pense no volume nomeado)?

## Critério de pronto

- `docker compose up -d --build` sobe os dois serviços sem erro.
- Uma tarefa criada sobrevive a `docker compose restart api`.
- `respostas.md` explica por que a tarefa sobrevive ao restart da API mas o que aconteceria se
  o volume do Redis fosse removido (`docker compose down -v`).

## Entrega

`docker-compose.yml` fica em `apps/task-api/docker-compose.yml`. Suba nesta pasta apenas
`respostas.md`. Veja [`solucao/`](solucao/) para referência.
