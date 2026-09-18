# Respostas — Prometheus na prática

## Targets descobertos

```bash
$ curl -s 'localhost:9090/api/v1/targets' | jq '.data.activeTargets[] | {pod: .labels.pod, health}'
```
```
task-api-6d878ffd-7lw95 -> up
task-api-6d878ffd-962zn -> up
```

Os dois Pods da `task-api` foram descobertos **automaticamente**, só pelas anotações
`prometheus.io/scrape`/`port`/`path` no manifest — nenhum endereço de Pod foi digitado à mão em
lugar nenhum da configuração do Prometheus.

## Query real depois de gerar tráfego

```bash
curl -X POST localhost:8080/tasks -d '{}'                        # 400 (sem title)
curl -X POST localhost:8080/tasks -d '{"title":"prom"}'            # 201
curl localhost:8080/health   # x5

curl 'localhost:9090/api/v1/query?query=task_api_requests_total'
```
```
method=GET  path=/health  status=200  -> 5
method=POST path=/tasks   status=400  -> 1
method=POST path=/tasks   status=201  -> 1
```

Os números batem exatamente com o tráfego gerado — o Prometheus está coletando de verdade, não
só respondendo "up" sem dado nenhum atrás.

## Decisões

- RBAC (`prometheus-rbac.yaml`) é obrigatório: sem um `ClusterRole` permitindo `get/list/watch`
  em `pods`, o Prometheus recebe erro 403 da API do Kubernetes e a lista de targets fica vazia
  — a descoberta de serviço depende de conseguir **perguntar** à API quem existe.
- O relabeling em `prometheus-configmap.yaml` é o que traduz metadado do Kubernetes
  (`__meta_kubernetes_pod_annotation_prometheus_io_port`) em configuração de scrape real
  (`__address__`) — sem isso, o Prometheus tentaria fazer scrape na porta padrão do Pod (a
  primeira exposta), não necessariamente `5000`.
