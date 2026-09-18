# Boas práticas de imagem

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### Multi-stage build: build numa imagem, roda em outra

Algumas dependências precisam de ferramentas de compilação (`gcc`, headers de sistema) só pra
**instalar** — depois de instaladas, essas ferramentas não servem pra nada em runtime, só
ocupam espaço e aumentam a superfície de ataque da imagem final.

```dockerfile
# --- estágio 1: builder, com tudo que precisa pra instalar dependências ---
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --target=/app/deps -r requirements.txt

# --- estágio 2: imagem final, só com o necessário pra RODAR ---
FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /app/deps /usr/local/lib/python3.12/site-packages
COPY app.py .
CMD ["python", "app.py"]
```

`COPY --from=builder` traz só o resultado do primeiro estágio — nenhuma ferramenta de build
sobra na imagem final. O Docker descarta o estágio `builder` inteiro depois que a imagem final
termina de ser montada.

### Outras práticas que reduzem tamanho e risco

- **`.dockerignore`**: evita copiar `.git/`, `venv/`, `__pycache__/` pra dentro da imagem —
  você já usou isso na Aula 02.
- **Tags específicas, nunca `latest`**: `python:3.12-slim` é reproduzível; `python:latest` muda
  de conteúdo sem você pedir, quebrando builds "do nada" meses depois.
- **`--no-cache-dir` no pip**: evita que o `pip` guarde uma cópia dos pacotes baixados dentro da
  própria imagem — útil na sua máquina, inútil (só ocupa espaço) numa imagem de produção.
- **Menos camadas, quando possível**: cada `RUN` vira uma camada; encadear comandos relacionados
  com `&&` numa linha só reduz overhead (mas não force isso a ponto de prejudicar legibilidade).

### Medindo o resultado

```bash
docker images task-api          # compara o tamanho das tags v1 (Aula 02) e v2 (multi-stage)
docker history task-api:v2        # mostra o tamanho de cada camada individualmente
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
