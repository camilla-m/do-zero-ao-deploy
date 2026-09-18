# Respostas — Boas práticas de imagem

```bash
docker build -t task-api:v2 .
docker run -d -p 5050:5000 --name task-api-v2 task-api:v2
curl localhost:5050/health   # {"status":"ok"} [200]
docker exec task-api-v2 whoami   # appuser
```

## Comparação de tamanho

| Imagem | Disk usage | Content size |
|---|---|---|
| `task-api:v1` (Aula 02, single-stage) | 238MB | 52.5MB |
| `task-api:v2` (esta aula, multi-stage) | 225MB | 49.2MB |

Redução de ~13MB (~5%) — real, mas modesta. Multi-stage build faz mais diferença quando o
estágio de build instala **ferramentas de compilação** (gcc, headers de sistema, `build-essential`)
que não são necessárias em runtime — para dependências C que precisam ser compiladas, é comum
ver reduções de centenas de MB. A `task-api` usa só Flask e o cliente Redis, ambos **pacotes
Python puros**, sem necessidade de compilação — por isso o ganho aqui vem só de não carregar o
cache do `pip` e os metadados de instalação na imagem final, não de eliminar ferramentas de
build (que a imagem `python:3.12-slim` já não inclui por padrão).

## Por que vale o padrão mesmo com ganho pequeno aqui

O padrão multi-stage não é sobre *esta* aplicação especificamente — é sobre ter uma estrutura
de Dockerfile que já está pronta pro dia em que uma dependência precisar compilar algo (ex:
`psycopg2` sem a versão `-binary`, bibliotecas de imagem/criptografia). Adotar o padrão cedo
custa quase nada e evita reescrever o Dockerfile inteiro quando esse dia chegar.
