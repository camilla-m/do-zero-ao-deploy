# Estratégias de deploy na prática

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### Rolling update: o padrão do Kubernetes, sem configurar nada extra

Quando você roda `kubectl set image` ou `helm upgrade` num Deployment, o Kubernetes já faz uma
**rolling update** por padrão: sobe Pods novos aos poucos, espera cada um ficar `Ready`, e só
então derruba um Pod antigo — nunca todos de uma vez. Zero downtime, na maioria dos casos, sem
nenhuma configuração extra.

```yaml
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%   # quantos Pods podem ficar indisponíveis durante o update
      maxSurge: 25%          # quantos Pods extras (acima de `replicas`) podem existir temporariamente
```

```bash
kubectl set image deployment/task-api task-api=task-api:v3
kubectl rollout status deployment/task-api      # acompanha em tempo real
kubectl rollout history deployment/task-api       # revisões anteriores
kubectl rollout undo deployment/task-api            # volta pra revisão anterior, também via rolling update
```

### Blue-green: dois ambientes completos, troca instantânea

Sobe a versão nova (**green**) **inteira**, em paralelo com a versão atual (**blue**), sem
receber tráfego ainda. Quando validada, troca o `selector` do Service de uma vez — de blue pra
green. Reverter é só trocar o `selector` de volta.

```
Service (selector: version=blue)  →  Deployment blue (rodando, recebendo tráfego)
                                       Deployment green (rodando, SEM tráfego, em validação)

# depois de validar green:
Service (selector: version=green)  →  Deployment green (agora recebendo tráfego)
                                        Deployment blue (ainda de pé, pronto pra rollback)
```

Vantagem: rollback instantâneo (é só trocar o selector de volta) e você testa a versão nova
com tráfego real de verdade antes de expor pra todo mundo, se quiser (via port-forward só na
green, por exemplo). Custo: dobra os recursos durante a transição — dois ambientes completos
rodando ao mesmo tempo.

### Canary: expõe a versão nova pra uma fatia pequena de tráfego

Em vez de trocar tudo de uma vez, uma pequena porcentagem do tráfego vai pra versão nova
primeiro (ex: 10%), o resto continua na antiga. Se as métricas (Módulo 5) continuarem saudáveis,
aumenta a fatia gradualmente até 100%. Kubernetes puro não tem canary nativo por
porcentagem de tráfego — isso normalmente vem de uma ferramenta por cima (Argo Rollouts,
Flagger, ou um Service Mesh) que foge do escopo deste curso, mas o **conceito** é o mesmo em
qualquer implementação: expor o risco de uma vez só é mais perigoso que expor aos poucos.

### Qual usar

| Estratégia | Custo de recurso | Velocidade de rollback | Quando usar |
|---|---|---|---|
| Rolling update | Baixo (padrão) | Rápido, mas gradual | Padrão pra maioria dos casos |
| Blue-green | Alto (2x durante transição) | Instantâneo | Mudanças arriscadas, precisa de rollback imediato |
| Canary | Médio | Gradual, com corte de risco cedo | Mudanças de alto risco, com boa observabilidade (Módulo 5) pra decidir se aumenta a fatia |

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
