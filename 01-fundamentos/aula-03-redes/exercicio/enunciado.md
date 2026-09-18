# Exercício — Redes para quem nunca viu rede na vida

## Parte 1 — Investigando uma requisição real

Rode e leia a saída com calma:

```bash
dig github.com +short
curl -v https://github.com 2>&1 | head -40
```

Responda em `respostas.md`:

1. Qual IP o `dig` retornou para `github.com`?
2. Na saída do `curl -v`, em que ordem aparecem: a conexão TCP (`Connected to...`), o handshake
   TLS (`SSL connection using...`) e o primeiro header HTTP (`> GET / HTTP/2`)? Cole os trechos
   correspondentes.
3. Qual foi o status HTTP da resposta (`< HTTP/2 ...`)?

## Parte 2 — Diagnosticando um container que não responde

Em [`dados/docker-compose.yml`](dados/docker-compose.yml) tem um serviço `web` (nginx) que
**não responde** quando você tenta acessá-lo. Sem olhar a resposta antes de tentar:

1. Suba o serviço: `docker compose -f dados/docker-compose.yml up -d`.
2. Tente `curl -I http://localhost:8080` — vai falhar.
3. Investigue usando pelo menos 3 destes comandos: `docker compose ps`, `docker compose logs
   web`, `docker port <container>`, `curl -v`.
4. Descubra a causa raiz e corrija o `docker-compose.yml`.
5. Confirme que `curl -I http://localhost:8080` agora retorna `200 OK`.

Documente em `respostas.md`: o que você tentou, o que a saída de cada comando revelou, e qual
era o problema.

## Critério de pronto

- `respostas.md` responde as 3 perguntas da Parte 1 com os trechos de saída correspondentes.
- `respostas.md` documenta o diagnóstico da Parte 2 e o `docker-compose.yml` corrigido está
  nesta pasta.
- `curl -I http://localhost:8080` retorna `200 OK` com o compose corrigido rodando.

## Entrega

Suba `respostas.md` e o `docker-compose.yml` corrigido nesta pasta. Veja [`solucao/`](solucao/)
para uma referência.
