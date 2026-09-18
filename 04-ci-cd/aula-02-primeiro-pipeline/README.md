# Primeiro pipeline com GitHub Actions

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### Onde o GitHub Actions procura pipelines

Todo arquivo `.yml` dentro de `.github/workflows/`, na raiz do repositório, é um **workflow**.
O GitHub detecta sozinho, sem nenhum cadastro externo — é por isso que este curso já pode ter
pipeline funcionando: o repositório já está no GitHub.

### Anatomia de um workflow

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Mostra versão do Python
        run: python3 --version
```

- **`on`**: os eventos que disparam o workflow — aqui, todo `push` na `main` e todo Pull
  Request (contra qualquer branch).
- **`jobs`**: um workflow tem 1+ jobs. Por padrão, jobs diferentes rodam **em paralelo**, em
  máquinas (runners) separadas e efêmeras.
- **`runs-on`**: qual imagem de runner usar — `ubuntu-latest` é a mais comum e gratuita em
  repositórios públicos.
- **`steps`**: a sequência de ações dentro de um job, executadas **em ordem**, na mesma
  máquina.
- **`uses`**: roda uma **action** pronta, publicada por alguém (aqui, `actions/checkout` — sem
  ela, o runner começa com um diretório vazio, sem o seu código).
- **`run`**: roda um comando de shell diretamente.

### Acompanhando a execução

Depois do primeiro `git push`, a aba **Actions** do repositório no GitHub mostra cada execução,
com o log completo de cada step — inclusive quando algo falha, com o comando exato e a saída de
erro.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
