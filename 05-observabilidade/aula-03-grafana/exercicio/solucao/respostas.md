# Respostas — Dashboards com Grafana

## Datasource provisionado automaticamente

```bash
$ curl -u admin:admin localhost:3000/api/datasources
```
```json
[{
  "name": "Prometheus",
  "type": "prometheus",
  "url": "http://prometheus:9090",
  "isDefault": true,
  "readOnly": true
}]
```

`"readOnly": true` confirma que veio do provisionamento (ConfigMap montado), não de alguém
clicando em "Add data source" na UI — ninguém consegue editar/apagar por acidente.

## Dashboard criado via API

```bash
curl -u admin:admin -X POST localhost:3000/api/dashboards/db \
  -H "Content-Type: application/json" -d @dashboard-payload.json
```
```json
{"status":"success","uid":"dfyo1g8ydjabkd","url":"/d/dfyo1g8ydjabkd/task-api","version":1}
```

3 painéis, um por query do roteiro:

1. **Requisições por segundo** — `rate(task_api_requests_total[5m])`
2. **Taxa de erro (4xx+5xx)** — `rate(task_api_requests_total{status=~"4..|5.."}[5m])`
3. **Latência p95** — `histogram_quantile(0.95, rate(task_api_request_duration_seconds_bucket[5m]))`

Ver [`dashboard.json`](dashboard.json) — exportado de verdade via `GET
/api/dashboards/uid/dfyo1g8ydjabkd`, não escrito à mão.

## O que cada painel mostrou, com o tráfego gerado na Aula 02

- **Requisições/s**: subiu visivelmente durante as rajadas de `curl`, voltando a zero nos
  intervalos parados — confirma que a métrica reflete tráfego real, em tempo real.
- **Taxa de erro**: só aparece diferente de zero no minuto em que fiz `POST /tasks` sem
  `title` (erro 400 de propósito) — o resto do tempo, zero.
- **Latência p95**: ficou na casa de poucos milissegundos (a aplicação é simples, sem I/O
  pesado) — o valor em si importa menos aqui do que confirmar que o painel **calcula e
  atualiza**, pronto pra aula seguir usando essa mesma base pra alertar (Aula 04) quando a
  latência ficar anormal de verdade.
