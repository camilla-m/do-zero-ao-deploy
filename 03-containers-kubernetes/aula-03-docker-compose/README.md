# Docker Compose

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### O problema que o Compose resolve

Até agora você rodou um container por vez, com `docker run` e uma porta na mão. Aplicações de
verdade quase sempre têm mais de uma peça — API, banco, cache — que precisam subir juntas, se
enxergar pela rede, e ter uma ordem de inicialização. Fazer isso na mão com vários `docker run`
funciona, mas não escala nem é reprodutível. O Compose descreve o conjunto inteiro num arquivo
`YAML` só.

### Um `docker-compose.yml` com dois serviços

```yaml
services:
  api:
    build: .
    ports:
      - "5000:5000"
    environment:
      REDIS_URL: redis://cache:6379/0
    depends_on:
      - cache

  cache:
    image: redis:7-alpine
    volumes:
      - redis-data:/data

volumes:
  redis-data:
```

Três coisas importantes aqui:

1. **Rede automática**: o Compose cria uma rede própria pro projeto, e cada serviço enxerga os
   outros **pelo nome do serviço** — é por isso que `REDIS_URL` aponta pra `redis://cache:6379`
   e não `localhost:6379`. Dentro da rede do Compose, `cache` resolve pro IP do container do
   Redis, via DNS interno do Docker.
2. **`depends_on`** controla **ordem de start**, não "espera ficar pronto" — o container do
   Redis pode estar de pé mas ainda inicializando quando a API já tentar conectar. Em produção,
   isso se resolve com retry na aplicação (o driver do Redis já faz isso) ou healthchecks — não
   é um problema deste curso agora, mas vale saber que existe.
3. **Volume nomeado** (`redis-data`): sem ele, os dados do Redis morrem quando o container é
   removido. Com o volume, os dados sobrevivem a `docker compose down` (mas não a
   `docker compose down -v`, que remove volumes também).

### Comandos

```bash
docker compose up -d          # sobe tudo, em background
docker compose ps              # status dos serviços
docker compose logs -f api      # logs de um serviço específico, em tempo real
docker compose down              # para e remove os containers (mantém volumes)
docker compose down -v            # para, remove containers E volumes
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
