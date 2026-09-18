# Exercício — Estratégias de deploy na prática

## Objetivo

Observar uma rolling update de verdade, passo a passo, no cluster `kind` local (Módulo 3) — e
provocar (e reverter) um rollback.

## Passo a passo

1. No cluster local, confirme quantas réplicas da `task-api` estão rodando:
   `kubectl --context kind-do-zero-ao-deploy get pods -l app=task-api`.
2. Em outro terminal, deixe rodando, pra ver a transição acontecer em tempo real:
   ```bash
   kubectl --context kind-do-zero-ao-deploy get pods -l app=task-api -w
   ```
3. Faça uma mudança pequena e visível em `apps/task-api/app.py` (ex: mude a mensagem de
   `/health` pra `{"status": "ok", "version": "v3"}`), rebuilde a imagem
   (`docker build -t task-api:v3 apps/task-api`), carregue no cluster
   (`kind load docker-image task-api:v3 --name do-zero-ao-deploy`).
4. Dispare a rolling update: `kubectl --context kind-do-zero-ao-deploy set image
   deployment/task-api task-api=task-api:v3`.
5. Observe no terminal do passo 2: Pods novos aparecem, ficam `Running`, só depois um Pod
   antigo é terminado — nunca todos de uma vez.
6. Confirme a nova versão: `curl` no `/health` (via port-forward) deve mostrar `"version":
   "v3"`.
7. Simule um problema: reverta de propósito. `kubectl --context kind-do-zero-ao-deploy rollout
   undo deployment/task-api`. Confirme que voltou pra versão anterior
   (`kubectl rollout history deployment/task-api`, e o `/health` sem `version`).

## Critério de pronto

- Você observou, ao vivo, Pods novos e antigos coexistindo brevemente durante o update (não
  todos trocando de uma vez).
- `kubectl rollout undo` reverteu com sucesso, também via rolling update.
- `respostas.md` explica: se você tivesse configurado `maxUnavailable: 0` em vez do padrão, o
  que mudaria no comportamento observado no passo 5?

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para referência.
