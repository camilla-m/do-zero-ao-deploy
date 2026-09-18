# Exercício — Seu primeiro Pod e Deployment

## Objetivo

Fazer deploy da `task-api` (imagem da Aula 04) no cluster `kind` da Aula 05, e observar o
Kubernetes recriar um Pod sozinho depois de você matá-lo de propósito.

## Passo a passo

1. Carregue a imagem local no cluster (kind não enxerga seu Docker local sozinho):
   ```bash
   kind load docker-image task-api:v2 --name do-zero-ao-deploy
   ```
2. Crie `deployment.yaml` nesta pasta com um Deployment chamado `task-api`, 2 réplicas, usando
   a imagem `task-api:v2`, `containerPort: 5000`. Adicione `imagePullPolicy: IfNotPresent` (sem
   isso, o Kubernetes tenta baixar de um registro remoto mesmo já tendo a imagem local).
3. Aplique: `kubectl --context kind-do-zero-ao-deploy apply -f deployment.yaml`.
4. Confirme: `kubectl --context kind-do-zero-ao-deploy get pods -l app=task-api` — as 2 réplicas
   devem chegar a `Running`.
5. Mate um Pod de propósito:
   ```bash
   kubectl --context kind-do-zero-ao-deploy delete pod <nome-de-um-dos-pods>
   ```
   Rode `kubectl get pods -l app=task-api` de novo, imediatamente depois — o que aconteceu?
6. Confirme os logs de um Pod rodando: `kubectl --context kind-do-zero-ao-deploy logs
   <nome-do-pod>`.

## Critério de pronto

- `kubectl get deployment task-api` mostra `2/2` prontos.
- Depois de deletar um Pod, o número de Pods voltou a 2 sem você rodar `kubectl apply` de novo.
- `respostas.md` explica, com suas palavras, **quem** recriou o Pod e **como** ele soube que
  precisava recriar (conecte com o Controller Manager, visto na Aula 05).

## Entrega

Suba `deployment.yaml` e `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para
referência.
