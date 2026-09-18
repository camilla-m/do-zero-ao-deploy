# Solução — Prometheus na prática

```bash
kubectl apply -f prometheus-rbac.yaml -f prometheus-configmap.yaml -f prometheus-deployment.yaml -f prometheus-service.yaml
kubectl port-forward svc/prometheus 9090:9090 &
curl 'localhost:9090/api/v1/targets'
```

Testado de verdade no cluster `kind-do-zero-ao-deploy`: os dois Pods da `task-api` (com as
anotações `prometheus.io/*` no `k8s/task-api-deployment.yaml`) foram descobertos
automaticamente e aparecem `up`. Ver [`respostas.md`](respostas.md) para os dados reais
coletados depois de gerar tráfego.
