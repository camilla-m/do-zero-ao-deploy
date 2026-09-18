# Respostas — Docker Compose

`docker-compose.yml` fica em [`apps/task-api/docker-compose.yml`](../../../../apps/task-api/docker-compose.yml)
— assim como o Dockerfile na Aula 02, é parte permanente da aplicação a partir de agora.

## Teste real

```bash
cd apps/task-api
docker compose up -d --build
curl -X POST localhost:5000/tasks -H 'Content-Type: application/json' -d '{"title":"via compose"}'
# {"done":false,"id":1,"title":"via compose"}

curl localhost:5000/tasks
# [{"done":false,"id":1,"title":"via compose"}]

docker compose restart api
curl localhost:5000/tasks
# [{"done":false,"id":1,"title":"via compose"}]   <-- sobreviveu ao restart
```

## Por que sobrevive ao restart da API, mas não necessariamente ao `down -v`

A tarefa sobrevive ao `docker compose restart api` porque ela nunca esteve na memória do
processo Python — está gravada no Redis, num processo **separado**, que não foi reiniciado.
Reiniciar a API só reinicia o cliente que lê/escreve no Redis, não o dado em si.

Se rodarmos `docker compose down -v`, o `-v` remove também os **volumes nomeados** — inclusive
o `redis-data`, onde o Redis persiste seu próprio estado em disco. Sem esse volume, o próximo
`docker compose up` sobe um Redis completamente vazio. `docker compose down` (sem `-v`) preserva
o volume — só remove containers e a rede — então um `up` seguinte recupera os dados.

## Resumo

| Comando | Containers | Rede | Volume (dados) |
|---|---|---|---|
| `docker compose restart api` | reinicia só a API | mantida | mantido |
| `docker compose down` | remove | remove | **mantido** |
| `docker compose down -v` | remove | remove | **removido** |
