# Exercício — Testes automatizados no pipeline

## Objetivo

Estender `.github/workflows/ci.yml` (Aula 02) pra instalar as dependências da `task-api` e
rodar a suíte `pytest` de verdade, a cada push/PR.

## Passo a passo

1. Edite `.github/workflows/ci.yml`: adicione `actions/setup-python@v5` (Python 3.12) e dois
   steps com `working-directory: apps/task-api` — um que instala `requirements-dev.txt`, outro
   que roda `pytest -v`.
2. Quebre um teste de propósito em `apps/task-api/tests/test_app.py` (ex: troque um
   `assert resp.status_code == 200` por `== 201`), commit, push, e confirme na aba Actions que
   o workflow **falha** e aponta exatamente qual teste quebrou.
3. Desfaça a quebra, commit, push, confirme que volta a passar.

## Critério de pronto

- O workflow instala dependências e roda `pytest` a cada push.
- Você viu, de verdade, um teste quebrado derrubar o workflow — com a mensagem de erro do
  `pytest` visível no log do GitHub Actions.

## Entrega

`.github/workflows/ci.yml` atualizado na raiz do repositório. Suba nesta pasta apenas
`respostas.md`. Veja [`solucao/`](solucao/) para referência.
