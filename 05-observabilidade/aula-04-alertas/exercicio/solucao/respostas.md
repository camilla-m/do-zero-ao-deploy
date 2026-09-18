# Respostas — Alertas

## Regra carregada

```bash
$ curl 'localhost:9090/api/v1/rules'
```
Confirma o grupo `task-api` com a regra `TaskApiIndisponivel`, `health: "ok"` — carregada sem
erro de sintaxe.

## Linha do tempo real, escalando a aplicação a zero

```bash
kubectl scale deployment/task-api --replicas=0
```

1. **Logo depois do scale**: `curl /api/v1/alerts` → `{"alerts": []}` — nada ainda, porque os
   Pods estavam em `Terminating`, não removidos de verdade.
2. **Depois dos Pods saírem por completo**: `curl /api/v1/targets` → `0` targets ativos. A regra
   passa a `state: "pending"`, `activeAt` registrado.
3. **~1-2 ciclos de avaliação depois** (o intervalo padrão de avaliação de grupo é 60s, e
   `for: 30s` precisa de pelo menos uma avaliação inteira depois de cruzar esse tempo): `state:
   "firing"`.
   ```json
   {
     "alertname": "TaskApiIndisponivel",
     "state": "firing",
     "activeAt": "2026-09-18T22:33:18Z",
     "value": "1e+00"
   }
   ```

```bash
kubectl scale deployment/task-api --replicas=2
```

4. Pods voltam, `curl /api/v1/targets` mostra os dois novos Pods com `health: "up"`.
5. Depois do próximo ciclo de avaliação (confirmado às `2026-09-18T22:38:13Z`), `curl
   /api/v1/alerts` volta a `{"alerts": []}`.

## O gotcha que apareceu testando de verdade

A primeira versão da regra (`up{...} == 0`, sem `absent()`) **nunca disparou** com o cluster
scalado a zero — porque, como o roteiro desta aula explica, sem nenhum Pod, a série `up{...}`
deixa de existir inteiramente, e `== 0` não casa com "série ausente". Só depois de trocar pra
`(up{...} == 0) or absent(up{...})` o alerta dispou de verdade. Isso não é um erro de digitação
raro — é o comportamento padrão do PromQL, e a razão pela qual alertas de disponibilidade
"prontos" (dashboards da comunidade, mixins) quase sempre incluem `absent()` ou equivalente.
