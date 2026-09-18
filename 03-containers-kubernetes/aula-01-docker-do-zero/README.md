# Docker do zero

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### Container não é máquina virtual

Uma VM virtualiza **hardware** — cada VM carrega seu próprio kernel, o que custa memória e
segundos de boot. Um container virtualiza **o sistema operacional**: todos os containers numa
máquina compartilham o mesmo kernel Linux, isolados uns dos outros por dois mecanismos do
próprio kernel — *namespaces* (isolamento de visão: cada container só enxerga seus próprios
processos, rede, filesystem) e *cgroups* (limite de recursos: quanto de CPU/memória cada um
pode usar). Resultado: containers sobem em milissegundos, não minutos.

### Imagem vs. container

- **Imagem**: um pacote read-only com tudo que a aplicação precisa pra rodar (código,
  dependências, SO base) — um "molde".
- **Container**: uma **instância em execução** de uma imagem, com uma camada de escrita por
  cima. A mesma imagem pode virar N containers rodando ao mesmo tempo, cada um isolado.

Analogia que gruda: imagem está pra container assim como classe está pra objeto, em programação
orientada a objetos.

### Comandos essenciais

```bash
docker pull nginx:alpine        # baixa uma imagem do registro (Docker Hub, por padrão)
docker images                    # lista imagens locais
docker run -d -p 8080:80 --name meu-nginx nginx:alpine   # cria E inicia um container
docker ps                         # containers rodando
docker ps -a                       # todos os containers, incluindo parados
docker logs meu-nginx               # stdout/stderr do container
docker exec -it meu-nginx sh         # abre um shell DENTRO do container rodando
docker inspect meu-nginx              # todos os detalhes (rede, mounts, config) em JSON
docker stop meu-nginx                  # para (sem remover)
docker rm meu-nginx                     # remove (precisa estar parado, ou use -f)
```

`-d` roda em background (*detached*). `-p host:container` mapeia porta — mesmo conceito que
você já viu na Aula 03 do Módulo 1, quando diagnosticou um container que não respondia.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
