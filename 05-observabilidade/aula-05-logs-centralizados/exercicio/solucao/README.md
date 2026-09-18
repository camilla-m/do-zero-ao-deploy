# Solução — Logs centralizados

```bash
kubectl apply -f loki-deployment.yaml -f loki-service.yaml
kubectl apply -f promtail-rbac.yaml -f promtail-configmap.yaml -f promtail-daemonset.yaml
kubectl apply -f grafana-datasource-configmap.yaml   # substitui o da Aula 03, agora com Loki tambem
kubectl rollout restart deployment/grafana
```

Testado de verdade: logs da `task-api` chegando no Loki via Promtail, consultáveis por
`{app="task-api"}`, sobrevivendo à morte dos Pods que os geraram. Ver
[`respostas.md`](respostas.md) para os dados reais e uma nota importante sobre por que este
Promtail usa `static_configs` em vez de `kubernetes_sd_configs`.
