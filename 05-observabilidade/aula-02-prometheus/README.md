# Prometheus na prática

**Módulo:** Módulo 5 — Observabilidade
**Duração:** ~1h

## Roteiro

### Prometheus não recebe métricas — ele vai buscar (pull, não push)

Diferente de muitas ferramentas de log, o Prometheus funciona por **scraping**: ele mesmo
acessa, periodicamente (a cada `scrape_interval`, geralmente 15-30s), um endpoint HTTP
`/metrics` de cada aplicação, e lê o estado atual dos contadores/histogramas. A aplicação só
precisa **expor** esse endpoint — não precisa saber nada sobre o Prometheus, nem enviar nada
ativamente.

### Instrumentando a aplicação: `prometheus_client`

```python
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

REQUEST_COUNT = Counter(
    "task_api_requests_total", "Total de requisicoes recebidas",
    ["method", "path", "status"],
)
REQUEST_LATENCY = Histogram(
    "task_api_request_duration_seconds", "Duracao das requisicoes, em segundos",
    ["method", "path"],
)

@app.get("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)
```

- **`Counter`**: só sobe (total de requisições, total de erros). Nunca diminui.
- **`Histogram`**: distribui observações em faixas (*buckets*) — é o que permite calcular
  percentis depois (p50, p95, p99 de latência), não só uma média que esconde outliers.
- **Cuidado com cardinalidade nos labels**: usar `request.path` cru como label criaria uma
  série temporal **por ID de tarefa** (`/tasks/1`, `/tasks/2`, `/tasks/3`...) — isso explode
  sem limite. A `task_api` usa `request.url_rule` (`/tasks/<int:task_id>`), que agrupa todas as
  tarefas na mesma série.

### Descoberta de serviço no Kubernetes: anotações no Pod

Em vez de listar cada aplicação manualmente na configuração do Prometheus, ele pode **descobrir
sozinho** quais Pods têm métricas, via anotações:

```yaml
template:
  metadata:
    annotations:
      prometheus.io/scrape: "true"
      prometheus.io/port: "5000"
      prometheus.io/path: "/metrics"
```

```yaml
# prometheus.yml
scrape_configs:
  - job_name: kubernetes-pods
    kubernetes_sd_configs:
      - role: pod
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: "true"
      - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
        action: replace
        regex: ([^:]+)(?::\d+)?;(\d+)
        replacement: $1:$2
        target_label: __address__
```

Qualquer Pod novo com essas anotações é descoberto automaticamente no próximo ciclo de
scraping — sem reconfigurar o Prometheus.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
