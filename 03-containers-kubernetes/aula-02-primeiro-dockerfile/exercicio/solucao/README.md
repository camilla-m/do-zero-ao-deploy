# Solução — Seu primeiro Dockerfile

O `Dockerfile` fica em [`apps/task-api/Dockerfile`](../../../../apps/task-api/Dockerfile) — a
partir desta aula, ele é parte permanente da aplicação, não um artefato isolado desta pasta.

```bash
cd apps/task-api
docker build -t task-api:v1 .
docker run -d -p 5000:5000 --name task-api-v1 task-api:v1
curl localhost:5000/health
docker exec task-api-v1 whoami
```

Ver [`respostas.md`](respostas.md) para a saída real capturada.

## Decisões

- `python:3.12-slim` em vez de `python:3.12` puro — a variante `slim` remove ferramentas de
  build e documentação que a aplicação não precisa em runtime, cortando dezenas de MB. A Aula
  04 aprofunda essa otimização com multi-stage build.
- `COPY requirements.txt .` e `RUN pip install` **antes** de `COPY app.py .` — assim, enquanto
  você só edita `app.py` (o normal, no dia a dia), o Docker reaproveita a camada de
  dependências já instaladas em vez de reinstalar tudo a cada build.
- Usuário não-root criado explicitamente (`useradd` + `USER appuser`) — a imagem base
  `python:3.12-slim` roda como root por padrão; se o container for comprometido, um processo
  root dentro dele tem bem mais poder de causar dano do que um usuário sem privilégios.
