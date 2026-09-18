# Testes automatizados no pipeline

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### De "roda um comando" pra "roda a suíte de testes de verdade"

A Aula 02 criou a estrutura da pipeline; agora ela ganha função: rodar os testes da
`task-api` (os mesmos `pytest` que você escreveu/rodou localmente no Módulo 3) a cada push e
a cada Pull Request.

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Instala dependências
        working-directory: apps/task-api
        run: pip install -r requirements-dev.txt

      - name: Roda testes
        working-directory: apps/task-api
        run: pytest -v
```

- **`actions/setup-python`**: instala a versão do Python especificada no runner — sem isso, você
  depende de qual versão o `ubuntu-latest` já vem com (que muda com o tempo, sem aviso).
- **`working-directory`**: evita ficar escrevendo `cd apps/task-api &&` em todo `run` — aplica a
  todos os comandos daquele step.
- Se `pytest` retornar código de saída diferente de zero (qualquer teste falhando), o step
  falha, o job falha, e o workflow inteiro aparece vermelho — é assim que um PR com teste
  quebrado fica visivelmente bloqueado antes de alguém aprovar o merge.

### Cache de dependências (opcional, mas comum)

```yaml
- uses: actions/setup-python@v5
  with:
    python-version: "3.12"
    cache: "pip"
    cache-dependency-path: apps/task-api/requirements-dev.txt
```

Evita reinstalar as mesmas dependências do zero a cada execução — pipelines rodam dezenas de
vezes por dia num time ativo; segundos economizados por execução somam rápido.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
