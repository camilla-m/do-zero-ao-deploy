# Exercício — Boas práticas de imagem

## Objetivo

Reescrever o `Dockerfile` da `task-api` usando multi-stage build, e comparar o tamanho final
com a versão da Aula 02.

## Passo a passo

1. Em `apps/task-api/Dockerfile`, reescreva usando dois estágios:
   - **`builder`**: `python:3.12-slim`, instala as dependências com `pip install
     --target=/app/deps`.
   - **final**: `python:3.12-slim` de novo, copia só `/app/deps` e `app.py` do estágio
     `builder` (nada de ferramentas de build sobrando).
   - Mantenha o usuário não-root da Aula 02.
2. Construa com uma tag nova: `docker build -t task-api:v2 .`.
3. Compare:
   ```bash
   docker images task-api
   docker history task-api:v2
   ```
4. Rode `task-api:v2` e confirme que ainda funciona: `curl localhost:5050/health` (ajuste a
   porta se colidir com o AirPlay, como nas aulas anteriores).

## Critério de pronto

- `docker build` da v2 conclui sem erro.
- `task-api:v2` responde `/health` normalmente.
- `respostas.md` compara o tamanho de `v1` (Aula 02) e `v2` (esta aula), com números reais —
  mesmo que a diferença seja pequena (é esperado, para uma aplicação Python pura como esta:
  explique por quê).

## Entrega

O `Dockerfile` atualizado fica em `apps/task-api/Dockerfile`. Suba nesta pasta apenas
`respostas.md`. Veja [`solucao/`](solucao/) para referência.
