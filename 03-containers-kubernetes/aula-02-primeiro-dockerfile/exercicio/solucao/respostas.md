# Respostas — Seu primeiro Dockerfile

```bash
cd apps/task-api
docker build -t task-api:v1 .
docker run -d -p 5050:5000 --name task-api-v1 task-api:v1   # 5050 no host: 5000 colide com o AirPlay Receiver no macOS
curl localhost:5050/health
```
```
{"status":"ok"}
```

```bash
docker exec task-api-v1 whoami
```
```
appuser
```

Build passou limpo, healthcheck retornou 200, e o processo dentro do container roda como
`appuser` — não `root`. Imagem final: **238MB** (ainda sem otimização — isso é assunto da
Aula 04).
