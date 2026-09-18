# Exercício — Introdução ao Kubernetes

## Objetivo

Subir um cluster local com `kind` e explorá-lo com `kubectl`, sem fazer deploy de nada ainda
(isso é a Aula 06) — só entendendo a topologia do cluster que você acabou de criar.

## Passo a passo

1. Crie o cluster: `kind create cluster --name do-zero-ao-deploy`.
2. Confirme o contexto do `kubectl` (kind já configura automaticamente):
   ```bash
   kubectl config current-context
   # deve mostrar: kind-do-zero-ao-deploy
   ```
3. Explore:
   ```bash
   kubectl --context kind-do-zero-ao-deploy get nodes                # quantos nodes existem?
   kubectl --context kind-do-zero-ao-deploy get nodes -o wide         # mais detalhes: SO, runtime
   kubectl --context kind-do-zero-ao-deploy get pods -A                # -A = todos os namespaces
   kubectl --context kind-do-zero-ao-deploy get namespaces
   kubectl --context kind-do-zero-ao-deploy cluster-info

   # se sua máquina só tem este cluster, pode omitir --context depois de conferir o passo 2 —
   # mas se você tem outros clusters/kind rodando, mantenha --context explícito sempre (ver
   # roteiro desta aula sobre por que isso importa)
   ```
4. Responda em `respostas.md`:
   - Quantos nodes o cluster tem por padrão?
   - Cite 2 Pods que já estavam rodando em `kube-system` antes de você fazer qualquer deploy, e
     pra que servem (pesquise: `coredns`, `kube-proxy`).
   - Qual é o "estado desejado" que esses Pods do sistema representam, e quem garante que eles
     continuam rodando?

## Critério de pronto

- `kubectl get nodes` mostra pelo menos 1 node com status `Ready`.
- `respostas.md` responde as 3 perguntas do passo 4.

## Entrega

Suba `respostas.md` nesta pasta. **Não derrube o cluster** ainda — as próximas aulas do módulo
vão usá-lo. Veja [`solucao/`](solucao/) para referência.
