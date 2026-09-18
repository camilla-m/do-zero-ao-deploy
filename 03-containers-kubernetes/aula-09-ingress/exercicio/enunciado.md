# Exercício — Ingress

## Objetivo

Recriar o cluster com portas publicadas pro host, instalar o `ingress-nginx`, e acessar a
`task-api` por domínio (`task-api.local`) em vez de `port-forward` ou `NodePort`.

## Passo a passo

1. Recrie o cluster com `extraPortMappings` (isso **apaga** o que estava rodando nele — tudo
   bem, você vai reaplicar):
   ```bash
   kind delete cluster --name do-zero-ao-deploy
   kind create cluster --name do-zero-ao-deploy --config kind-config.yaml
   ```
   Confira `kind-config.yaml` — mapeia a porta 80/443 do node pra 8080/8443 do host (evita
   precisar de root pra abrir porta <1024).
2. **Confira `kubectl config current-context`** depois do `kind create` — ele muda sozinho (ver
   aviso da Aula 05). Se sua máquina tem outros clusters, volte pro context que você usava antes
   de continuar com outra coisa.
3. Instale o `ingress-nginx`:
   ```bash
   kubectl --context kind-do-zero-ao-deploy apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
   kubectl --context kind-do-zero-ao-deploy wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=150s
   ```
4. Recarregue a imagem e reaplique os manifests das Aulas 07 e 08 (Redis, ConfigMap, Secret,
   Deployment, Service da `task-api`) — tudo foi apagado com o cluster.
5. Crie `ingress.yaml` roteando `task-api.local` pro Service `task-api`, porta 80.
6. Teste **sem mexer no `/etc/hosts`** — use `--resolve` do curl pra simular o DNS numa
   requisição só:
   ```bash
   curl --resolve task-api.local:8080:127.0.0.1 http://task-api.local:8080/health
   ```

## Critério de pronto

- `kubectl get pods -n ingress-nginx` mostra o controller `Running`.
- `curl --resolve task-api.local:8080:127.0.0.1 http://task-api.local:8080/health` retorna
  `{"status": "ok"}`.
- `respostas.md` explica a diferença entre o `Ingress` (a regra) e o `ingress-nginx` (quem
  executa a regra).

## Entrega

Suba `kind-config.yaml`, `ingress.yaml` e `respostas.md` nesta pasta. Veja
[`solucao/`](solucao/) para referência.
