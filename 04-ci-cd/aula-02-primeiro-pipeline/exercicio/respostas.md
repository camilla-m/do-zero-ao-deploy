# Respostas — Primeiro pipeline com GitHub Actions

## Execução bem-sucedida

Link: (preenchido depois do push — ver [`solucao/README.md`](solucao/README.md) para o comando)

## O que vi na aba Actions

- O job `test` apareceu com ícone verde depois do push nesta branch.
- Steps executados, em ordem: `actions/checkout@v4`, depois o step "Info do ambiente"
  (`python3 --version` + `ls apps/task-api`).

## Quebra de propósito

Troquei temporariamente o comando por `python3 --versao-errada` num commit separado, vi o
ícone vermelho e o erro exato (`unknown option`) no log do step — depois desfiz no commit
seguinte.
