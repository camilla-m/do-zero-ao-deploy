# Respostas — O que é integração contínua na prática

| # | Passo manual | Tempo | Risco se esquecido/errado |
|---|---|---|---|
| 1 | Editar `app.py` | variável | — |
| 2 | Rodar `pytest` localmente | ~1min | Bug conhecido vai pra produção sem ninguém notar |
| 3 | `docker build -t task-api:vN .` | ~10-30s | Imagem com código antigo, se esquecer de rebuildar |
| 4 | `kind load docker-image task-api:vN` | ~5s | Cluster continua rodando a imagem anterior, silenciosamente |
| 5 | Atualizar a tag da imagem no `values.yaml`/manifest | ~30s | Cluster nunca atualiza — aplica a mesma versão de sempre |
| 6 | `helm upgrade` / `kubectl apply` | ~10s | Ninguém percebe que "esqueceu de dar deploy" até um usuário reclamar |
| 7 | Verificar manualmente se subiu certo (`kubectl get pods`, `curl /health`) | ~1min | Deploy quebrado fica no ar sem ninguém saber |

Total: uns 3-5 minutos **quando tudo dá certo** — e cada um dos 7 passos é uma chance de
esquecimento, principalmente o 2 (pular teste sob pressão) e o 7 (não conferir depois).

## O que vira automação nas próximas aulas

- **Passo 2** (rodar testes): Aula 03 — todo push roda a suíte automaticamente.
- **Passos 3-4** (build + carregar imagem): Aula 04 — pipeline builda e publica a imagem sem
  intervenção manual.
- **Passos 5-6** (atualizar deploy): Aula 05 — pipeline aplica o novo deploy no cluster
  automaticamente após build+testes passarem.
- **Passo 7** (verificar que subiu certo): também Aula 05 — smoke test automático no final da
  pipeline, ao invés de checar na mão.

O que **não** desaparece: alguém ainda decide *o que* codar, e revisa *o que* vai ser
integrado (via Pull Request) — CI/CD automatiza a **execução mecânica** dos passos repetitivos,
não o julgamento humano sobre o código em si.
