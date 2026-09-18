# Exercício — Deploy contínuo até o Kubernetes

## Objetivo

Adicionar um job `deploy` ao `ci.yml`: cria um cluster `kind` efêmero **dentro do runner**,
aplica os manifests da aplicação, e faz um smoke test — tudo automaticamente, só em push na
`main`.

## Passo a passo

1. Copie os manifests de Redis do Módulo 3 (Aula 08) pra uma pasta `k8s/` na raiz do
   repositório: `redis-deployment.yaml`, `redis-service.yaml`.
2. Adicione o job `deploy` ao `ci.yml`, com `needs: build-push` e
   `if: github.event_name == 'push' && github.ref == 'refs/heads/main'`.
3. Use a action `helm/kind-action@v1` pra criar o cluster dentro do job.
4. Aplique: ConfigMap/Secret (via `kubectl create ... --from-literal`, direto no workflow — sem
   arquivo, pra manter o exemplo simples), o Redis, e o Deployment/Service da `task-api`
   usando a imagem publicada pela Aula 04 (`ghcr.io/.../task-api:${{ github.sha }}`).
5. Adicione um smoke test: `kubectl rollout status`, depois um `curl --fail` no `/health` via
   `port-forward`.
6. Push, acompanhe o job `deploy` rodar do zero — cluster criado, aplicação no ar, smoke test
   passando — tudo dentro de uma execução do GitHub Actions.

## Critério de pronto

- O job `deploy` só roda depois de `build-push`, e só em push na `main`.
- O smoke test (`curl --fail`) passa no log do workflow.
- `respostas.md` explica por que este cluster é **efêmero** (existe só durante a execução do
  job) e o que isso significa pra confiabilidade do teste: ele prova que o manifest funciona
  num cluster limpo, não que "funciona na minha máquina que já tem tudo configurado".

## Entrega

`ci.yml` e `k8s/` atualizados na raiz do repositório. Suba nesta pasta apenas `respostas.md`.
Veja [`solucao/`](solucao/) para referência.
