# Respostas — Introdução ao Kubernetes

```bash
$ kubectl --context kind-do-zero-ao-deploy get nodes -o wide
NAME                              STATUS   ROLES           AGE   VERSION
do-zero-ao-deploy-control-plane   Ready    control-plane   38m   v1.37.0
```

## Quantos nodes por padrão?

**1 node**, que acumula os dois papéis (control-plane e worker) — `kind create cluster` sem
configuração extra cria um cluster de nó único, suficiente pra aprender e testar. Em produção
real, o control-plane normalmente fica em nodes dedicados, separados dos workers.

## 2 Pods do sistema e pra que servem

```
kube-system   coredns-559f6c778d-8b992   1/1   Running
kube-system   coredns-559f6c778d-99xht   1/1   Running
kube-system   kube-proxy-fg6vk           1/1   Running
```

- **`coredns`** (2 réplicas): o servidor DNS interno do cluster. É o que permite um Pod
  encontrar outro pelo **nome do Service**, em vez de decorar IP — o mesmo papel que o Compose
  faz automaticamente entre serviços (Módulo 3, Aula 03), só que agora em escala de cluster.
- **`kube-proxy`**: roda em cada node, mantém as regras de rede (iptables/IPVS) que fazem o
  tráfego destinado a um Service chegar até um dos Pods certos — é a peça que faz
  `ClusterIP`/`NodePort` funcionarem de verdade (mais sobre isso na Aula 07).

## Estado desejado e quem garante

Esses Pods do sistema também são geridos por Deployments/DaemonSets do próprio Kubernetes — o
mesmo Controller Manager que vai gerenciar a `task-api` a partir da Aula 06 já está, agora,
garantindo que `coredns` e `kube-proxy` continuam rodando. Kubernetes usa a própria máquina de
reconciliação pra manter seus componentes internos de pé — não é um mecanismo especial só pra
aplicações de usuário.
