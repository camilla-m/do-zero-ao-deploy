# Seu primeiro Dockerfile

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### As instruções que você vai usar em quase todo Dockerfile

```dockerfile
FROM python:3.12-slim      # imagem base — sempre a primeira linha
WORKDIR /app                 # todo comando seguinte roda a partir daqui
COPY requirements.txt .       # copia arquivo(s) do seu computador pra dentro da imagem
RUN pip install -r requirements.txt   # executa um comando NA CONSTRUÇÃO da imagem
COPY . .                       # copia o resto do código
EXPOSE 5000                     # documentação: qual porta a aplicação usa (não abre porta sozinho)
CMD ["python", "app.py"]         # comando executado quando o CONTAINER inicia (não na build)
```

### `RUN` (build time) vs. `CMD` (run time) — a confusão mais comum de quem começa

- `RUN` executa **uma vez, durante `docker build`**, e o resultado vira uma camada da imagem
  (ex: instalar dependências).
- `CMD` (ou `ENTRYPOINT`) define o que roda **toda vez que um container sobe** dessa imagem —
  não acontece na build, só no `docker run`.

### Camadas e cache

Cada instrução do Dockerfile vira uma **camada**. O Docker reaproveita camadas que não mudaram
entre builds — por isso a ordem importa: copiar `requirements.txt` e instalar dependências
**antes** de copiar o resto do código faz o `pip install` só rodar de novo quando as
dependências mudarem, não a cada alteração de código.

```bash
docker build -t task-api:v1 .        # constrói a imagem, tag "v1"
docker run -d -p 5000:5000 task-api:v1
docker images task-api                # confirma que a imagem existe
```

**No macOS**, a porta 5000 do host é usada pelo AirPlay Receiver — se `curl localhost:5000/...`
der `403` em vez da resposta da API, ou é isso, ou desative AirPlay Receiver em Configurações
do Sistema, ou mapeie pra outra porta do host (`-p 5050:5000`) e ajuste o `curl` de acordo.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
