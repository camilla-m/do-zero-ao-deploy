# Respostas — Redes

## Parte 1

Saída de exemplo (o IP do GitHub varia — eles usam vários, atrás de um balanceador):

```bash
$ dig github.com +short
140.82.112.3
```

**1. IP retornado:** `140.82.112.3` (varia por região/tempo — o importante é que o `dig`
retorna um IP e não um erro).

**2. Ordem na saída do `curl -v`:**

```
*   Trying 140.82.112.3:443...
* Connected to github.com (140.82.112.3) port 443
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256
> GET / HTTP/2
```

Primeiro a conexão TCP (`Connected to...`), depois o handshake TLS (`SSL connection using...`),
só depois o primeiro byte de HTTP é enviado. Faz sentido: HTTPS é HTTP rodando **por cima** de
uma conexão já criptografada — a criptografia acontece antes de qualquer dado de aplicação
trafegar.

**3. Status HTTP:** `HTTP/2 200`.

## Parte 2 — diagnóstico do container

**Comando 1 — reproduzir o problema:**
```bash
$ curl -I --max-time 3 http://localhost:8080
curl: (52) Empty reply from server
```
A conexão TCP abre (não é "connection refused"), mas ninguém responde do outro lado — isso já
descarta "porta fechada no host" e aponta pra algo dentro do container.

**Comando 2 — `docker compose ps`:**
```
NAME          IMAGE          PORTS
dados-web-1   nginx:alpine   80/tcp, 0.0.0.0:8080->8080/tcp
```
Aqui está a pista: a imagem expõe `80/tcp` (é isso que o nginx escuta por padrão), mas o
mapeamento configurado é `8080->8080` — ou seja, o Docker está encaminhando a porta 8080 do
host para a porta **8080 do container**, onde não tem nada escutando.

**Comando 3 — `docker compose logs web`:**
```
web-1 | 2026/09/18 ... nginx/1.31.6
web-1 | 2026/09/18 ... start worker processes
```
O nginx sobe normalmente — o processo está saudável, então o problema não é a aplicação, é o
mapeamento de porta.

**Causa raiz:** `ports: ["8080:8080"]` deveria ser `ports: ["8080:80"]` — a sintaxe é
`"porta-do-host:porta-do-container"`, e a porta do container tem que ser a que o processo lá
dentro realmente escuta (80, no caso do nginx).

**Correção** (ver [`docker-compose.yml`](docker-compose.yml)):
```yaml
ports:
  - "8080:80"
```

**Confirmação:**
```bash
$ curl -I http://localhost:8080
HTTP/1.1 200 OK
Server: nginx/1.31.6
```
