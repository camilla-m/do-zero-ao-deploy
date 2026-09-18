# Exercício — Build e push de imagem automatizado

## Objetivo

Adicionar um job `build-push` ao `ci.yml` que builda a imagem da `task-api` e publica no GHCR,
só depois que os testes (Aula 03) passarem.

## Passo a passo

1. Adicione o job `build-push` ao `.github/workflows/ci.yml`, com `needs: test`,
   `permissions: packages: write`, login no GHCR via `docker/login-action`, e build+push via
   `docker/build-push-action`, com `context: apps/task-api` (onde está o `Dockerfile` da Aula
   02 do Módulo 3).
2. Marque as duas tags: `latest` e `${{ github.sha }}`.
3. Push, acompanhe na aba Actions: o job `test` deve rodar primeiro, e só depois `build-push`.
4. Confira a imagem publicada na aba **Packages** do seu perfil/repositório no GitHub.

## Critério de pronto

- O workflow tem 2 jobs: `test` e `build-push`, nessa ordem de dependência.
- Uma imagem nova aparece em Packages a cada push na `main`, com a tag do SHA do commit.

## Entrega

`.github/workflows/ci.yml` atualizado. Suba nesta pasta apenas `respostas.md`. Veja
[`solucao/`](solucao/) para referência.
