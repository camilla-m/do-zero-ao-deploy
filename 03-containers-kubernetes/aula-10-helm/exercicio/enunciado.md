# Exercício — Helm

## Objetivo

Transformar os manifests das Aulas 06-09 (Deployment, Service, ConfigMap, Secret) num Helm
chart, parametrizando pelo menos: número de réplicas, tag da imagem, e os valores do
ConfigMap.

## Passo a passo

1. Crie a estrutura do chart em `task-api-chart/`:
   ```
   task-api-chart/
   ├── Chart.yaml
   ├── values.yaml
   └── templates/
       ├── deployment.yaml
       ├── service.yaml
       └── configmap.yaml
   ```
   (Secret fica de fora do Helm neste exercício de propósito — em produção real, segredo
   normalmente vem de um cofre externo, não de `values.yaml` em texto puro; aqui, aplique o
   `secret.yaml` da Aula 08 separadamente, fora do chart.)
2. `templates/deployment.yaml` deve usar `{{ .Values.replicaCount }}`,
   `{{ .Values.image.repository }}:{{ .Values.image.tag }}`.
3. `templates/configmap.yaml` deve usar `{{ .Values.logLevel }}` e `{{ .Values.appName }}`.
4. Preencha `values.yaml` com os valores atuais (2 réplicas, `task-api:v2`, etc).
5. Renderize sem instalar, pra conferir: `helm template task-api-chart`.
6. Instale: `helm install task-api-release ./task-api-chart` (aplique o `secret.yaml` da Aula 08
   antes, separadamente).
7. Mude `replicaCount` pra 3 em `values.yaml` e rode `helm upgrade task-api-release
   ./task-api-chart` — confirme com `kubectl get pods -l app=task-api` que agora são 3.

## Critério de pronto

- `helm template task-api-chart` renderiza sem erro e produz um Deployment, Service e
  ConfigMap válidos.
- `helm install` sobe a aplicação com sucesso.
- `helm upgrade` com `replicaCount: 3` resulta em 3 Pods rodando.
- `respostas.md` explica por que o Secret ficou de fora do chart.

## Entrega

Suba `task-api-chart/` e `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para
referência.
