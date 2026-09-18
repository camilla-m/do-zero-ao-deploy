# Exercício — Primeiro pipeline com GitHub Actions

## Objetivo

Criar seu primeiro workflow: dispara a cada push, faz checkout do código e roda um comando
simples — a base que a Aula 03 vai estender com testes de verdade.

## Passo a passo

1. Crie `.github/workflows/ci.yml`, na **raiz do repositório** (não dentro desta pasta — é
   assim que o GitHub Actions encontra workflows):
   - `on`: `push` (em qualquer branch, pra simplificar) e `pull_request`.
   - Um job `test`, `runs-on: ubuntu-latest`.
   - Steps: `actions/checkout@v4`, depois um step que roda `python3 --version` e `ls
     apps/task-api`.
2. Commit e push. Abra a aba **Actions** do repositório no GitHub e confirme que o workflow
   rodou e passou (ícone verde).
3. Quebre de propósito: mude o comando pra algo que não existe (ex: `python3
   --versao-errada`), commite, e observe o workflow **falhar** (ícone vermelho) — depois
   desfaça.

## Critério de pronto

- O workflow aparece na aba Actions do GitHub e termina com sucesso.
- Você viu, pelo menos uma vez, o workflow falhar de propósito — pra reconhecer como isso se
  parece antes de acontecer sem querer.

## Entrega

O workflow fica em `.github/workflows/ci.yml`, na raiz do repositório. Suba nesta pasta apenas
um `respostas.md` com o link (ou print) da execução bem-sucedida. Veja [`solucao/`](solucao/)
para referência.
