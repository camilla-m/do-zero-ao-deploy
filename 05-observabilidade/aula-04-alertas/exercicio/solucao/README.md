# Solução — Alertas

```bash
kubectl apply -f prometheus-rules-configmap.yaml -f prometheus-configmap.yaml -f prometheus-deployment.yaml
kubectl rollout restart deployment/prometheus   # recarrega config/regras

kubectl port-forward svc/prometheus 9090:9090 &
curl 'localhost:9090/api/v1/rules'
```

`prometheus-configmap.yaml` e `prometheus-deployment.yaml` aqui **substituem** os da Aula 02 —
adicionam `rule_files` e o volume das regras. Ver [`respostas.md`](respostas.md) pra a linha do
tempo real de pending → firing → limpo, testada de verdade escalando a aplicação a zero e
depois restaurando.
