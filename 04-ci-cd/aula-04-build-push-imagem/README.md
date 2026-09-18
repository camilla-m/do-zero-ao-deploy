# Build e push de imagem automatizado

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### GHCR: o registro de imagens que já vem com o repositório

Toda imagem Docker precisa viver num **registro** (registry) pra ser baixada em outro lugar
(como o cluster). Você poderia usar o Docker Hub, mas o **GitHub Container Registry (GHCR)** já
vem disponível pra qualquer repositório GitHub, autenticado com o mesmo token que a Actions já
tem — sem cadastro nem segredo extra pra configurar.

```yaml
jobs:
  build-push:
    runs-on: ubuntu-latest
    needs: test              # só builda se os testes passarem
    permissions:
      contents: read
      packages: write          # necessário pra publicar no GHCR
    steps:
      - uses: actions/checkout@v4

      - name: Login no GHCR
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build e push
        uses: docker/build-push-action@v6
        with:
          context: apps/task-api
          push: true
          tags: |
            ghcr.io/${{ github.repository }}/task-api:latest
            ghcr.io/${{ github.repository }}/task-api:${{ github.sha }}
```

Três decisões importantes aqui:

- **`needs: test`**: este job só roda depois que o job `test` (Aula 03) terminar **com
  sucesso**. Sem `needs`, jobs rodam em paralelo — publicar uma imagem cujos testes ainda nem
  terminaram de rodar seria voltar a esconder o problema que CI existe pra resolver.
- **`secrets.GITHUB_TOKEN`**: um token temporário que a Actions **gera sozinha**, por execução —
  você não cria nem cola credencial nenhuma; só precisa declarar `permissions: packages: write`
  pra esse token ganhar autorização de publicar pacotes.
- **Duas tags**: `latest` (sempre a versão mais recente) e `${{ github.sha }}` (o hash exato do
  commit) — a segunda existe pra sempre ser possível apontar de volta pra uma versão específica,
  mesmo depois que `latest` avançar. A Aula 05 usa a tag do SHA pra fazer deploy de uma versão
  exata, não de "o que quer que `latest` seja quando alguém rodar isso".

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
