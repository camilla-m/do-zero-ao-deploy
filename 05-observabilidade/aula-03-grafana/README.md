# Dashboards com Grafana

**Módulo:** Módulo 5 — Observabilidade
**Duração:** ~1h

## Roteiro

### Prometheus guarda os números, Grafana os torna legíveis

O Prometheus tem sua própria interface de consulta (`/graph`, que você já usou na Aula 02), mas
ela é feita pra explorar métricas pontualmente, não pra manter um painel permanente que
qualquer pessoa do time olha todo dia. **Grafana** conecta numa fonte de dados (Prometheus,
entre várias outras) e monta **dashboards**: painéis salvos, combináveis, com gráficos, contador
numérico, tabelas — tudo declarável como JSON, versionável como qualquer outro artefato deste
curso.

### PromQL: a linguagem de consulta por trás de cada painel

```promql
# taxa de requisições por segundo, nos últimos 5 minutos, por status
rate(task_api_requests_total[5m])

# só as com erro (5xx)
rate(task_api_requests_total{status=~"5.."}[5m])

# latência p95 (95% das requisições respondem mais rápido que isso)
histogram_quantile(0.95, rate(task_api_request_duration_seconds_bucket[5m]))
```

- **`rate(...[5m])`**: converte um `Counter` (que só sobe) numa **taxa por segundo**, calculada
  sobre a janela dos últimos 5 minutos — é assim que "quantas requisições por segundo" nasce de
  um número que só acumula.
- **`histogram_quantile`**: usa os *buckets* do `Histogram` (que você definiu no código, Aula
  02) pra estimar em que faixa ficam os 95% mais rápidos das requisições — a métrica que
  interessa quando "a média está ok, mas uma fatia dos usuários sofre" (a média sozinha esconde
  isso; percentil não).

### Provisionando datasource e dashboard como código

Em vez de configurar Grafana clicando (e perder tudo se o Pod reiniciar sem volume persistente),
ele aceita **provisionamento**: arquivos YAML/JSON montados via ConfigMap, lidos na
inicialização.

```yaml
# datasource.yaml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: http://prometheus:9090
    isDefault: true
```

O dashboard em si é um JSON (exportável pela própria UI do Grafana depois de montado uma vez, ou
escrito à mão) — o exercício desta aula usa um dashboard pronto, versionado no repositório.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
