# Respostas — Services e exposição de aplicação

```bash
kubectl apply -f service.yaml
kubectl get svc task-api
```
```
NAME       TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
task-api   NodePort   10.96.19.238   <none>        80:30500/TCP   0s
```

```bash
kubectl port-forward svc/task-api 8080:80 &
curl localhost:8080/health
# {"status":"ok"} [200]
```

## Depois de deletar os dois Pods

```bash
kubectl delete pod task-api-c7b66b984-7ml92 task-api-c7b66b984-j55p8 --wait=false
kubectl get pods -l app=task-api
```
```
NAME                       READY   STATUS        AGE
task-api-c7b66b984-289gl   1/1     Running       8s   <- pods novos
task-api-c7b66b984-7ml92   1/1     Terminating   2m2s
task-api-c7b66b984-h7r5b   1/1     Running       8s   <- pods novos
task-api-c7b66b984-j55p8   1/1     Terminating   2m12s
```

O `port-forward` antigo morreu junto com os Pods que ele estava segurando (esperado — ele fala
com um Pod específico por trás do Service). Refazendo:

```bash
kubectl port-forward svc/task-api 8080:80 &
curl localhost:8080/health
# {"status":"ok"} [200]   <- funcionando, contra os Pods NOVOS
```

## Por que funcionou sem reconfigurar nada

O Service nunca guarda uma lista fixa de IPs de Pod — ele resolve, **a cada requisição**, quais
Pods atualmente têm a label `app: task-api` (o mesmo `selector` do `service.yaml`) e distribui
tráfego entre eles. Quando os Pods antigos morreram e o ReplicaSet criou os novos (com a mesma
label, herdada do `template` do Deployment), o Service passou a enxergá-los automaticamente —
o endpoint do Service (`kubectl get endpoints task-api` mostra isso na prática) é atualizado
pelo próprio Kubernetes, sem eu tocar em `service.yaml`.

Isso é o ponto central de um Service: ele é o endereço **estável** que absorve a
instabilidade natural dos Pods por baixo.
