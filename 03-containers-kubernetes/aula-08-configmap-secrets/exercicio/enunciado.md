# Exercício — ConfigMaps e Secrets

## Objetivo

Levar o Redis pro cluster também (Deployment + Service, como fez com a `task-api`), e migrar a
`task-api` pra ler `REDIS_URL` de um Secret e um `LOG_LEVEL`/`APP_NAME` de um ConfigMap, em vez
de variáveis soltas no Deployment.

## Passo a passo

1. Crie `redis-deployment.yaml` e `redis-service.yaml`: Deployment `redis:7-alpine` (1
   réplica), Service `ClusterIP` chamado `cache`, porta `6379`.
2. Crie `configmap.yaml` (`LOG_LEVEL`, `APP_NAME`) e `secret.yaml` (`REDIS_URL:
   redis://cache:6379/0`, usando `stringData`).
3. Atualize o `deployment.yaml` da `task-api` (copie o da
   [Aula 06](../aula-06-pod-deployment/exercicio/solucao/deployment.yaml)) pra usar `envFrom`
   apontando pro ConfigMap e pro Secret.
4. Aplique tudo (ordem importa: Redis e ConfigMap/Secret antes da `task-api`, senão ela sobe sem
   achar o Redis ainda de pé — embora o Kubernetes tente de novo sozinho, é mais limpo aplicar
   na ordem certa):
   ```bash
   kubectl --context kind-do-zero-ao-deploy apply -f redis-deployment.yaml -f redis-service.yaml
   kubectl --context kind-do-zero-ao-deploy apply -f configmap.yaml -f secret.yaml
   kubectl --context kind-do-zero-ao-deploy apply -f deployment.yaml
   ```
5. Confirme que as variáveis chegaram no Pod:
   ```bash
   kubectl --context kind-do-zero-ao-deploy exec deploy/task-api -- env | grep -E "REDIS_URL|LOG_LEVEL|APP_NAME"
   ```
6. Confirme que a API está usando o Redis de verdade (mesmo teste de persistência da Aula 03,
   agora dentro do cluster): crie uma tarefa via `port-forward`, delete o Pod da `task-api`, e
   confirme que a tarefa sobrevive.

## Critério de pronto

- `kubectl exec deploy/task-api -- env` mostra as 3 variáveis vindas do ConfigMap/Secret.
- Uma tarefa criada sobrevive à recriação do Pod da `task-api` (prova de que está indo pro
  Redis, não pra memória).
- `respostas.md` mostra a saída do passo 5 e explica a diferença de tratar `REDIS_URL` como
  Secret mesmo sem senha aqui (pense: e se este Redis tivesse `requirepass` configurado?).

## Entrega

Suba os arquivos `.yaml` e `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para
referência.
