# Introdução ao Kubernetes

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### O problema que o Kubernetes resolve

Docker Compose funciona bem numa máquina só. Mas e quando a aplicação precisa rodar em várias
máquinas, se recuperar sozinha quando um container morre, escalar sob demanda, e distribuir
tráfego entre réplicas? Isso é orquestração — e Kubernetes é o orquestrador que virou padrão de
indústria.

### Arquitetura, em alto nível

```
Control Plane (o "cérebro")            Worker Nodes (onde os containers rodam)
┌─────────────────────────┐            ┌─────────────────────────┐
│ API Server  <───────────┼── kubectl  │  kubelet (agente)        │
│ etcd (estado do cluster)│            │  Pods                     │
│ Scheduler                │            │  ...                      │
│ Controller Manager        │           └─────────────────────────┘
└─────────────────────────┘            ┌─────────────────────────┐
                                         │  kubelet, Pods, ...       │
                                         └─────────────────────────┘
```

- **API Server**: a porta de entrada — todo `kubectl` fala com ele, via HTTP/REST.
- **etcd**: banco de dados que guarda o estado desejado do cluster inteiro.
- **Scheduler**: decide em qual node cada Pod novo deve rodar.
- **Controller Manager**: fica comparando "o que existe" com "o que foi declarado", e corrige
  divergências — é a raiz de como o Kubernetes se **auto-cura** (mais na Aula 06).
- **kubelet**: roda em cada node, é quem de fato conversa com o Docker (ou outro runtime) pra
  subir os containers dos Pods designados àquele node.

### O modelo declarativo

Você não diz "suba um container". Você declara **o estado desejado** ("eu quero 3 réplicas
desta aplicação rodando, sempre") num arquivo YAML, manda pro cluster (`kubectl apply`), e o
Controller Manager garante que a realidade convirja pra isso — inclusive recriando um Pod que
morreu, sem você pedir de novo.

### kind: Kubernetes dentro de um container Docker

`kind` (Kubernetes IN Docker) cria um cluster Kubernetes de verdade, rodando cada "node" como
um container Docker na sua máquina — grátis, rápido de subir e derrubar, perfeito pra aprender
e testar sem custo de nuvem.

```bash
kind create cluster --name do-zero-ao-deploy
kubectl cluster-info --context kind-do-zero-ao-deploy
kubectl get nodes
```

### Cuidado: `kind create cluster` muda seu context padrão

Assim que o cluster sobe, `kind` troca o **contexto atual** do `kubectl` pra ele
automaticamente (`kubectl config current-context`). Se você já tinha outro cluster em uso —
outro projeto, outro `kind`, um cluster real — qualquer comando `kubectl` sem `--context`
explícito passa a mirar no cluster novo **sem avisar**. Se tiver algum script ou processo
rodando em background que fala com o Kubernetes usando o context "atual" (em vez de um fixo),
ele muda de alvo silenciosamente junto.

Em máquinas com mais de um cluster, o hábito mais seguro é **sempre** passar `--context`
explícito nos comandos, em vez de confiar em qual é "o atual" no momento:

```bash
kubectl --context kind-do-zero-ao-deploy get nodes
kubectl config get-contexts          # lista todos os contexts conhecidos
kubectl config use-context <nome>     # troca o "atual" de propósito, quando for isso que você quer
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
