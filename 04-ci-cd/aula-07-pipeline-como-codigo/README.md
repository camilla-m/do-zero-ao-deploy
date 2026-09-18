# Pipeline como código

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### O problema: pipeline duplicada entre projetos (ou entre jobs)

Com um projeto só, `ci.yml` cresce sem problema. Mas assim que você tem 2+ repositórios com a
mesma stack (Python + Flask, digamos), copiar e colar os mesmos steps de "instala dependências
e roda pytest" em cada um significa: toda melhoria (cache melhor, nova versão do Python) precisa
ser replicada manualmente, projeto por projeto — o mesmo problema de duplicação que motivou o
Helm no Módulo 3, agora na camada de CI.

### Reusable workflows: um workflow chamando o outro

```yaml
# .github/workflows/reusable-test.yml
name: Reusable - Test Python App

on:
  workflow_call:
    inputs:
      working-directory:
        required: true
        type: string

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"
      - name: Instala dependências
        working-directory: ${{ inputs.working-directory }}
        run: pip install -r requirements-dev.txt
      - name: Roda testes
        working-directory: ${{ inputs.working-directory }}
        run: pytest -v
```

```yaml
# .github/workflows/ci.yml — chamando o reusable acima
jobs:
  test:
    uses: ./.github/workflows/reusable-test.yml
    with:
      working-directory: apps/task-api
```

`on: workflow_call` é o que transforma um workflow normal em algo **chamável** por outro —
`inputs` define o que quem chama precisa fornecer, do mesmo jeito que uma função recebe
parâmetros. Diferente de uma **action** composta (outra forma de reuso no GitHub Actions,
focada em reusar *steps*), um reusable workflow reusa **jobs inteiros**, incluindo `runs-on` e
paralelismo entre eles.

### Onde isso ganha mais valor

Um reusable workflow pode viver num repositório **separado**, e outros repositórios da mesma
organização o chamam via `uses: org/repo-central/.github/workflows/test.yml@main` — um único
lugar pra manter a lógica de "como testamos qualquer app Python" pra dezenas de projetos.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
