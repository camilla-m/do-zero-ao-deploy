# Exercício — Logs centralizados

## Objetivo

Instalar Loki (armazenamento de log) e Promtail (agente coletor, um DaemonSet) no cluster,
conectar como datasource no Grafana da Aula 03, e provar que um log sobrevive à morte do Pod
que o gerou.

## Passo a passo

1. Crie `loki-deployment.yaml`/`loki-service.yaml`: Loki rodando em modo standalone (sem
   storage externo — filesystem local do Pod já serve pro exercício).
2. Crie `promtail-daemonset.yaml`: um DaemonSet que lê os logs dos containers do node
   (`/var/log/pods` montado como `hostPath`) e envia pro Loki. Configure via `static_configs`
   com um glob de path mirando a `task-api` (`/var/log/pods/*task-api*/task-api/*.log`) — a
   alternativa "mais elegante" seria `kubernetes_sd_configs` (igual ao Prometheus, Aula 02),
   descobrindo Pods automaticamente; se quiser tentar, vá em frente, mas não é garantido — nos
   testes deste curso, a descoberta automática do Promtail simplesmente não encontrou nenhum
   target, sem erro nenhum no log, em duas versões de imagem testadas. `static_configs` é a
   versão testada e funcionando.
3. Adicione Loki como datasource no Grafana (mais um ConfigMap de provisionamento, como na Aula
   03, agora `type: loki`, apontando pra `http://loki:3100`).
4. Gere logs: `curl` algumas vezes na `task-api` pra garantir que tem log recente.
5. Confirme via Grafana → Explore → datasource Loki: consulte `{app="task-api"}` e veja os logs
   aparecerem.
6. Prove a persistência: `kubectl delete pod -l app=task-api` (mata os Pods atuais), espere os
   novos subirem, e **repita a mesma consulta LogQL** — os logs dos Pods antigos (já mortos)
   ainda devem aparecer, porque foram coletados **antes** de morrerem.

## Critério de pronto

- A consulta `{app="task-api"}` no Grafana Explore (ou via API do Loki) retorna linhas de log
  reais.
- Depois de matar os Pods, os logs dos Pods antigos continuam consultáveis — mesmo que
  `kubectl logs <pod-antigo>` já não funcione mais (o Pod não existe).

## Entrega

Suba os manifests e `respostas.md` (com a query usada e uma amostra do resultado, antes e
depois de matar os Pods) nesta pasta. Veja [`solucao/`](solucao/) para referência.
