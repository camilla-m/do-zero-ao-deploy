# Seu primeiro Pod e Deployment

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### Pod: a menor unidade que o Kubernetes gerencia

Um **Pod** é um ou mais containers que sempre rodam juntos, no mesmo node, compartilhando rede
e storage — na prática, quase sempre um Pod = um container. Você raramente cria um Pod
diretamente; quase sempre usa algo que **gerencia** Pods pra você.

### Deployment: o que garante que o Pod continua existindo

Um Pod criado sozinho, se morrer, morre — ninguém recria. Um **Deployment** declara "eu quero N
réplicas deste Pod, sempre" e delega a um **ReplicaSet** a tarefa de garantir isso. Se um Pod
cai, o Controller Manager percebe a divergência entre estado desejado e real, e o ReplicaSet
sobe um novo Pod pra repor.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: task-api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: task-api
  template:
    metadata:
      labels:
        app: task-api
    spec:
      containers:
        - name: task-api
          image: task-api:v2
          ports:
            - containerPort: 5000
```

Repare na estrutura: `spec.template` é, em si, a definição de um Pod — o Deployment só embrulha
isso com "quantas réplicas" e "como encontrar os Pods que eu crio" (`selector.matchLabels`,
que precisa bater com `template.metadata.labels`).

### Levando a imagem local pro cluster

Um cluster `kind` não enxerga as imagens Docker da sua máquina automaticamente — é preciso
carregá-las explicitamente:

```bash
kind load docker-image task-api:v2 --name do-zero-ao-deploy
```

Sem isso, o Kubernetes tenta baixar a imagem de um registro remoto e falha (`ErrImagePull`),
porque `task-api:v2` só existe localmente.

### Comandos essenciais

```bash
kubectl apply -f deployment.yaml     # cria ou atualiza
kubectl get deployments               # status do deployment
kubectl get pods                       # os pods geridos por ele
kubectl describe pod <nome>             # detalhes + eventos (ótimo pra debugar)
kubectl logs <nome-do-pod>               # stdout/stderr do container
kubectl delete pod <nome>                 # mata um pod de propósito — observe o Deployment recriar
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
