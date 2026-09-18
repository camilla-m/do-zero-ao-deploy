# Respostas — Seu primeiro Pod e Deployment

```bash
kind load docker-image task-api:v2 --name do-zero-ao-deploy
kubectl --context kind-do-zero-ao-deploy apply -f deployment.yaml
kubectl --context kind-do-zero-ao-deploy get deployment task-api
```
```
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
task-api   2/2     2            2           5s
```

## Deletando um Pod de propósito

```bash
$ kubectl delete pod task-api-c7b66b984-hhg5j
pod "task-api-c7b66b984-hhg5j" deleted

$ kubectl get pods -l app=task-api
NAME                       READY   STATUS    RESTARTS   AGE
task-api-c7b66b984-7ml92   1/1     Running   0          34s   <- pod NOVO, recriado
task-api-c7b66b984-j55p8   1/1     Running   0          44s   <- pod original, intacto
```

## Quem recriou, e como

O **ReplicaSet** criado pelo Deployment (`task-api-c7b66b984`) está constantemente comparando
"quantos Pods com a label `app=task-api` existem agora" contra "`spec.replicas: 2`, declarado
no YAML". Quando o Pod `hhg5j` foi deletado, essa contagem caiu pra 1 — o ReplicaSet Controller
(parte do Controller Manager) detectou a divergência e criou um Pod novo
(`task-api-c7b66b984-7ml92`) imediatamente, sem eu pedir nada além do delete.

Repare que o **nome mudou** (`7ml92` em vez de `hhg5j`) — não é o mesmo Pod "voltando", é um
Pod **novo**, criado do zero a partir do mesmo `template`. Isso importa: qualquer estado que só
existisse dentro daquele Pod específico (arquivo em disco local, por exemplo) se perde — é
exatamente por isso que a `task-api` guarda dados no Redis (Aula 03) e não em memória, quando
rodando de verdade.

## Logs do pod novo

```
 * Serving Flask app 'app'
 * Running on http://10.244.0.7:5000
```

A aplicação subiu normalmente no Pod recriado — sem nenhuma ação manual da minha parte além do
`delete`.
