# Exercício — Pipeline como código

## Objetivo

Extrair o job `test` do `ci.yml` pra um workflow reutilizável, e confirmar que o pipeline
continua funcionando exatamente igual, agora chamando esse workflow em vez de repetir os steps.

## Passo a passo

1. Crie `.github/workflows/reusable-test.yml`, com `on: workflow_call` e um input
   `working-directory` (obrigatório, tipo `string`).
2. Mova os steps de checkout, setup Python e rodar testes do `ci.yml` pra dentro desse
   workflow, usando `${{ inputs.working-directory }}` no lugar de `apps/task-api` fixo.
3. No `ci.yml`, troque o job `test` por uma chamada:
   ```yaml
   test:
     uses: ./.github/workflows/reusable-test.yml
     with:
       working-directory: apps/task-api
   ```
4. Ajuste `needs: test` no job `build-push` se precisar (continua igual — o nome do job não
   muda, só o que está dentro dele).
5. Push, confirme na aba Actions que o pipeline inteiro (test → build-push → deploy) continua
   passando, agora com o job `test` mostrando que veio de um workflow chamado.

## Critério de pronto

- `ci.yml` não tem mais os steps de teste diretamente — só a chamada `uses:`.
- O pipeline completo continua passando, do jeito que já estava passando na Aula 05.
- `respostas.md` explica em que cenário (mesmo hipotético, se este curso tivesse 2 projetos)
  esse reuso economizaria trabalho de verdade.

## Entrega

`.github/workflows/reusable-test.yml` e `ci.yml` atualizados. Suba nesta pasta apenas
`respostas.md`. Veja [`solucao/`](solucao/) para referência.
