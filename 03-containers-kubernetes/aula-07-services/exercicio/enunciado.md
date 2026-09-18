# Exercício — Services e exposição de aplicação

## Objetivo

Criar um Service `NodePort` pra `task-api` (Deployment da Aula 06) e acessá-la de fora do
cluster.

## Passo a passo

1. Crie `service.yaml` nesta pasta: Service `NodePort`, `selector: app: task-api`, `port: 80`,
   `targetPort: 5000`, `nodePort: 30500`.
2. Aplique: `kubectl --context kind-do-zero-ao-deploy apply -f service.yaml`.
3. Confirme: `kubectl --context kind-do-zero-ao-deploy get svc task-api` — `TYPE` deve mostrar
   `NodePort`, com a porta `80:30500/TCP`.
4. **Sobre acessar via NodePort no `kind`**: por padrão, o `kind` **não publica** a porta do
   node pro seu host — a porta 30500 só é alcançável de dentro da rede Docker do cluster, a
   menos que o cluster tenha sido criado com `extraPortMappings` (fora do escopo desta aula).
   Pra confirmar que o Service está roteando corretamente, use `kubectl port-forward`, que
   funciona sempre, sem depender de configuração de rede do cluster:
   ```bash
   kubectl --context kind-do-zero-ao-deploy port-forward svc/task-api 8080:80 &
   curl localhost:8080/health
   ```
5. Mate os dois Pods (`kubectl delete pod <nome1> <nome2>`) e, assim que os novos subirem, repita
   o `curl` do passo 4 (pode precisar refazer o `port-forward`, que morre se o Pod que ele
   segurava sumir) — confirme que o Service já está roteando pros Pods novos, sem você mudar
   nada no `service.yaml`.

## Critério de pronto

- `kubectl get svc task-api` mostra `TYPE: NodePort`.
- `curl localhost:8080/health` (via port-forward) retorna `{"status": "ok"}`.
- `respostas.md` explica por que o Service continuou funcionando depois dos Pods serem
  recriados, sem reconfiguração manual (conecte com o `selector`, do roteiro).

## Entrega

Suba `service.yaml` e `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para referência.
