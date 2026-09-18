# Services e exposição de aplicação

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### Por que Pods sozinhos não bastam

Cada Pod tem um IP, mas esse IP é **efêmero** — some quando o Pod morre, e o substituto (Aula
06) nasce com outro. Nada que depende de "falar com o Pod X" sobrevive a um restart. Um
**Service** resolve isso: é um endereço **estável**, que sempre aponta pros Pods certos (via
`selector`, o mesmo mecanismo de labels do Deployment), não importa quantas vezes eles sejam
recriados.

### Os três tipos que você vai usar

```
ClusterIP (padrão)      NodePort                  LoadBalancer
     │                       │                          │
  só dentro do          + porta fixa em            + provisiona um
  cluster                cada node, acessível        balanceador externo
                          de fora                     (cloud provider)
```

- **`ClusterIP`**: IP interno, só alcançável de dentro do cluster. Padrão pra comunicação
  serviço-a-serviço (ex: sua API falando com um banco).
- **`NodePort`**: abre uma porta fixa (30000-32767) em **todos** os nodes, encaminhando pro
  Service. Funciona em qualquer cluster, inclusive local — é o que você vai usar aqui.
- **`LoadBalancer`**: pede ao provedor de nuvem um balanceador de carga real, com IP público.
  Não existe em `kind` sem ferramenta extra — é o que você usaria numa AWS/GCP de verdade.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: task-api
spec:
  type: NodePort
  selector:
    app: task-api
  ports:
    - port: 80          # porta do Service (dentro do cluster)
      targetPort: 5000    # porta do container (deve bater com containerPort do Pod)
      nodePort: 30500       # porta fixa exposta em cada node (só p/ NodePort)
```

`selector: app: task-api` é o que conecta o Service aos Pods certos — o Service não sabe nada
sobre o Deployment, só sabe "mande tráfego pra qualquer Pod com essa label". Se o Deployment
recriar um Pod, o Service já enxerga o novo automaticamente, sem reconfiguração.

### `kubectl port-forward`: acesso rápido, sem criar Service

Pra debug rápido, sem expor nada de verdade:
```bash
kubectl port-forward svc/task-api 8080:80
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
