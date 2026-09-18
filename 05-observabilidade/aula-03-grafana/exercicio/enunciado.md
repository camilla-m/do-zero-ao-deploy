# Exercício — Dashboards com Grafana

## Objetivo

Instalar Grafana no cluster, conectar no Prometheus da Aula 02 via provisionamento (sem clicar
em nada na UI), e montar um dashboard com pelo menos 3 painéis sobre a `task-api`.

## Passo a passo

1. Crie `grafana-datasource-configmap.yaml`: um ConfigMap com o YAML de datasource apontando
   pra `http://prometheus:9090` (mesmo namespace, então o nome do Service já resolve via DNS
   interno do cluster — Módulo 3, Aula 07).
2. Crie `grafana-deployment.yaml` e `grafana-service.yaml`: Grafana montando o ConfigMap de
   datasource no caminho de provisionamento
   (`/etc/grafana/provisioning/datasources/`).
3. Aplique tudo, acesse via `kubectl port-forward svc/grafana 3000:3000`
   (usuário/senha padrão: `admin`/`admin` — a menos que você tenha configurado diferente).
4. Confirme que o datasource Prometheus já aparece configurado, sem você precisar adicionar
   manualmente (Configuration → Data Sources).
5. Monte um dashboard com 3 painéis, usando as queries do roteiro:
   - Taxa de requisições por segundo (`rate(task_api_requests_total[5m])`).
   - Taxa de erro (`rate(task_api_requests_total{status=~"4..|5.."}[5m])`).
   - Latência p95 (`histogram_quantile(0.95, rate(task_api_request_duration_seconds_bucket[5m]))`).
6. Gere tráfego variado (`curl` em `/health`, `/tasks`, e também uma rota que dá erro, tipo
   `POST /tasks` sem `title`) e observe os painéis reagirem.
7. Exporte o dashboard (Dashboard settings → JSON Model) e salve como `dashboard.json` nesta
   pasta.

## Critério de pronto

- O datasource Prometheus aparece já configurado, sem configuração manual.
- Os 3 painéis mostram dados reais, reagindo ao tráfego gerado.
- `dashboard.json` está salvo nesta pasta.

## Entrega

Suba os manifests, `dashboard.json` e `respostas.md` (com um resumo do que cada painel mostrou)
nesta pasta. Veja [`solucao/`](solucao/) para referência.
