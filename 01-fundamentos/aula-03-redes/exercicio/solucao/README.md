# Solução — Redes

Ver [`respostas.md`](respostas.md) para as respostas completas das duas partes, e
[`docker-compose.yml`](docker-compose.yml) para o arquivo corrigido da Parte 2 (mapeamento de
porta `8080:80` em vez de `8080:8080`).

Testado localmente:
```bash
docker compose -f docker-compose.yml up -d
curl -I http://localhost:8080   # HTTP/1.1 200 OK
docker compose -f docker-compose.yml down
```
