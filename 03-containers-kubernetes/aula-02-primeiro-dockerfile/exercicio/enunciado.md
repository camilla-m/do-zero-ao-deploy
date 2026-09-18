# Exercício — Seu primeiro Dockerfile

## Objetivo

Dockerizar a `task-api` — a aplicação fornecida em [`apps/task-api/`](../../../apps/task-api/),
na raiz do repositório, que vai ser usada pelo resto do curso.

## Passo a passo

1. Em `apps/task-api/`, crie um `Dockerfile`:
   - Imagem base: `python:3.12-slim`.
   - Copie `requirements.txt` primeiro, rode `pip install`, **depois** copie o resto do código
     (nessa ordem, pelo motivo explicado no roteiro — cache de camadas).
   - Rode como um usuário **não-root** (crie um usuário no Dockerfile e mude pra ele antes do
     `CMD`) — rodar como root dentro do container é um hábito ruim que sai caro em produção.
   - `EXPOSE 5000` e `CMD` rodando `python app.py`.
2. Construa e rode:
   ```bash
   cd apps/task-api
   docker build -t task-api:v1 .
   docker run -d -p 5000:5000 --name task-api-v1 task-api:v1
   curl localhost:5000/health
   ```
3. Confirme que o container **não** está rodando como root:
   ```bash
   docker exec task-api-v1 whoami
   ```

## Critério de pronto

- `docker build` conclui sem erro.
- `curl localhost:5000/health` retorna `{"status": "ok"}`.
- `docker exec task-api-v1 whoami` **não** imprime `root`.

## Entrega

O `Dockerfile` fica em `apps/task-api/Dockerfile` (não duplicado aqui — é parte da aplicação a
partir de agora). Suba nesta pasta apenas um `respostas.md` confirmando os testes acima. Veja
[`solucao/`](solucao/) para referência.
