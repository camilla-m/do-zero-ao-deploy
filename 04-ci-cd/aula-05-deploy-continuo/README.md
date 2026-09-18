# Deploy contínuo até o Kubernetes

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### Fechando o ciclo: de um `git push` até rodando no cluster

As Aulas 02-04 já testam e publicam a imagem sozinhas. Falta o último elo: aplicar essa imagem
num cluster Kubernetes, automaticamente. Este curso usa `kind` — então a pipeline precisa criar
um cluster **efêmero**, dentro do próprio runner do GitHub Actions, a cada execução. Não é
"conectar num cluster que já existe em algum lugar" — é subir um do zero, testar, e descartar.

Isso é exatamente o que times fazem pra rodar **testes de integração contra Kubernetes de
verdade** antes de tocar num cluster de produção.

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    needs: build-push
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4

      - name: Cria cluster kind
        uses: helm/kind-action@v1
        with:
          cluster_name: ci

      - name: Aplica manifests
        run: |
          kubectl create configmap task-api-config \
            --from-literal=LOG_LEVEL=info --from-literal=APP_NAME=task-api
          kubectl create secret generic task-api-secret \
            --from-literal=REDIS_URL=redis://cache:6379/0
          kubectl apply -f k8s/redis-deployment.yaml -f k8s/redis-service.yaml
          kubectl set image deployment/task-api task-api=ghcr.io/${{ github.repository }}/task-api:${{ github.sha }} --dry-run=client -o yaml | kubectl apply -f -

      - name: Smoke test
        run: |
          kubectl rollout status deployment/task-api --timeout=90s
          kubectl port-forward svc/task-api 8080:80 &
          sleep 3
          curl --fail http://localhost:8080/health
```

- **`if: ... github.ref == 'refs/heads/main'`**: só faz deploy quando o push é **na `main`**,
  não em qualquer branch/PR — testar e buildar acontece sempre; "aplicar" fica restrito ao que
  já foi aprovado.
- **`kubectl rollout status`**: espera ativamente até o Deployment estar de fato saudável, com
  timeout — sem isso, o próximo step (`curl`) rodaria contra Pods que ainda nem terminaram de
  subir.
- **`curl --fail`**: sem `--fail`, o `curl` retorna sucesso (exit 0) mesmo recebendo um `500`
  — o job continuaria "verde" com a aplicação quebrada. `--fail` faz o `curl` retornar erro em
  qualquer status HTTP ≥ 400, o que derruba o step (e o workflow) se o smoke test falhar de
  verdade.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
