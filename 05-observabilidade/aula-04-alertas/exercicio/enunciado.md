# Exercício — Alertas

## Objetivo

Criar uma regra de alerta que dispara quando a `task-api` fica indisponível, e **provar que
funciona** derrubando a aplicação de propósito.

## Passo a passo

1. Crie `prometheus-rules-configmap.yaml`: um ConfigMap com uma regra `TaskApiIndisponivel`
   (`up{...} == 0`, `for: 30s` — mais curto que o roteiro, pra não esperar demais no exercício).
2. Monte esse ConfigMap no Prometheus (mais um `volumeMount`, e adicione `rule_files:` no
   `prometheus.yml` apontando pro arquivo).
3. Reaplique o Prometheus. Confirme a regra carregada em
   `http://localhost:9090/api/v1/rules` (via port-forward).
4. Derrube a aplicação de propósito: `kubectl scale deployment/task-api --replicas=0`.
5. Espere ~30-60s, consulte `http://localhost:9090/api/v1/alerts` — o alerta
   `TaskApiIndisponivel` deve aparecer, primeiro como `pending`, depois `firing`.
6. Restaure: `kubectl scale deployment/task-api --replicas=2`. Confirme que o alerta volta a
   sumir depois que os Pods voltam e o scrape volta a funcionar.

## Critério de pronto

- `curl localhost:9090/api/v1/rules` mostra a regra carregada.
- Depois do `scale --replicas=0`, o alerta aparece em `/api/v1/alerts` com estado `firing`.
- Depois de restaurar as réplicas, o alerta desaparece.

## Entrega

Suba os manifests e `respostas.md` (com a saída real das consultas, nos 3 momentos: antes,
durante, depois) nesta pasta. Veja [`solucao/`](solucao/) para referência.
