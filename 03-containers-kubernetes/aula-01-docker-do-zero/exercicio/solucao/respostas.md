# Respostas — Docker do zero

## Processos dentro do container (`docker exec meu-nginx ps aux`)

```
PID   USER     TIME  COMMAND
    1 root      0:00 nginx: master process nginx -g daemon off;
   30 nginx     0:00 nginx: worker process
   31 nginx     0:00 nginx: worker process
   32 nginx     0:00 nginx: worker process
   33 nginx     0:00 nginx: worker process
   34 root      0:00 ps aux
```

5 processos "reais" (1 master + 4 workers), mais o próprio `ps aux` rodando. Numa máquina Linux
comum, `ps aux` sem container mostra facilmente 100+ processos (todo o SO, serviços, daemons).
Isso é o *namespace* de PID do container em ação: de dentro dele, você só enxerga os processos
que pertencem àquele container — o resto do sistema operacional host simplesmente não existe
do ponto de vista do container.

## Diferença de tamanho: `nginx:alpine` vs `nginx:latest`

```
IMAGE          DISK USAGE   CONTENT SIZE
nginx:alpine   93.9MB       27.1MB
nginx:latest   271MB        67.9MB
```

`nginx:alpine` é bem menor porque usa Alpine Linux como base — uma distro construída em cima da
`musl libc` (em vez da `glibc` das distros comuns), com só o essencial instalado. `nginx:latest`
usa Debian como base, que traz muito mais ferramentas e bibliotecas de sistema "por garantia" —
mais compatibilidade, mais peso.

## O que "isolado" significou no passo 4

Os dois containers (`meu-nginx` na porta 8080, `nginx-2` na porta 8081) rodaram a **mesma
imagem** ao mesmo tempo, cada um com seu próprio processo `nginx`, seu próprio filesystem
(camada de escrita separada) e sem saber da existência um do outro — mudar um arquivo dentro de
`nginx-2` não afeta `meu-nginx` em nada, mesmo os dois vindo do mesmo molde. Isolamento aqui
significa: mesma imagem, execuções completamente independentes.
