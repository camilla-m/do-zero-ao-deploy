# Exercício — Prometheus na prática

## Objetivo

Instalar Prometheus no cluster `kind` local e confirmar que ele está coletando as métricas da
`task-api` sozinho, via descoberta automática por anotação.

## Passo a passo

1. A `task-api` já expõe `/metrics` (ver `apps/task-api/app.py`) — confirme localmente:
   `curl localhost:5000/metrics | grep task_api`.
2. Adicione as anotações `prometheus.io/scrape`, `prometheus.io/port`, `prometheus.io/path` no
   `template.metadata` do Deployment da `task-api` (`k8s/task-api-deployment.yaml`).
3. Crie `prometheus-configmap.yaml`, `prometheus-deployment.yaml` e `prometheus-service.yaml`
   nesta pasta — um Prometheus mínimo, com RBAC pra descoberta de Pods
   (`ClusterRole`/`ClusterRoleBinding` lendo `pods` — sem isso, o Prometheus não consegue
   perguntar à API do Kubernetes quais Pods existem).
4. Rebuilde a imagem da `task-api` (agora com `/metrics`), carregue no cluster, reaplique o
   Deployment.
5. Aplique os manifests do Prometheus.
6. Confirme via port-forward: `kubectl port-forward svc/prometheus 9090:9090`, abra
   `http://localhost:9090/targets` (ou consulte a API: `curl
   'localhost:9090/api/v1/targets'`) — os Pods da `task-api` devem aparecer com status `up`.
7. Gere um pouco de tráfego (`curl` em `/health` e `/tasks` algumas vezes) e confirme, via
   `http://localhost:9090/api/v1/query?query=task_api_requests_total`, que o Prometheus já tem
   os números.

## Critério de pronto

- `curl 'localhost:9090/api/v1/targets'` mostra os Pods da `task-api` com `"health":"up"`.
- Uma query a `task_api_requests_total` no Prometheus retorna valores reais, batendo com o
  tráfego gerado.

## Entrega

Suba os manifests do Prometheus e `respostas.md` (com a saída real das consultas) nesta pasta.
Veja [`solucao/`](solucao/) para referência.
