# Respostas — ConfigMaps e Secrets

```bash
kubectl apply -f redis-deployment.yaml -f redis-service.yaml
kubectl apply -f configmap.yaml -f secret.yaml
kubectl apply -f deployment.yaml
```

## Variáveis dentro do Pod

```bash
$ kubectl exec deploy/task-api -- env | grep -E "REDIS_URL|LOG_LEVEL|APP_NAME"
APP_NAME=task-api
LOG_LEVEL=info
REDIS_URL=redis://cache:6379/0
```

As três chegaram — `APP_NAME` e `LOG_LEVEL` vindas do `configMapRef`, `REDIS_URL` do
`secretRef` — sem nenhuma delas escrita diretamente no `deployment.yaml`.

## Teste de persistência dentro do cluster

```bash
kubectl port-forward svc/task-api 8080:80 &
curl -X POST localhost:8080/tasks -H 'Content-Type: application/json' -d '{"title":"configmap e secret"}'
# {"done":false,"id":1,"title":"configmap e secret"}

kubectl delete pod -l app=task-api --wait=false
# aguarda os pods novos subirem...

kubectl port-forward svc/task-api 8080:80 &   # o anterior morreu junto com os pods antigos
curl localhost:8080/tasks
# [{"done":false,"id":1,"title":"configmap e secret"}]   <- sobreviveu
```

## Por que `REDIS_URL` é Secret mesmo sem senha, aqui

Neste ambiente de estudo, o Redis não tem `requirepass` configurado — então `REDIS_URL` hoje
não carrega segredo nenhum de fato. Mas a **connection string** é o tipo de valor que, em
qualquer ambiente real, vai evoluir pra incluir usuário e senha
(`redis://user:senha@cache:6379/0`) ou, no caso de um banco relacional, quase sempre já nasce
com credencial embutida. Tratar isso como Secret desde o início evita ter que **migrar** o
manifest inteiro (e caçar todo lugar que referenciava a variável) no dia em que a senha for
adicionada — o padrão de acesso (`envFrom: secretRef`) já está certo, só o conteúdo do Secret
muda.

Vale reforçar (do roteiro): um Secret do Kubernetes sozinho não é criptografia — é convenção +
controle de acesso (RBAC) sobre quem pode ler aquele objeto. A separação de ConfigMap/Secret já
é o hábito certo; segurança adicional (criptografia do etcd, Secret managers externos) vem por
cima disso, não no lugar.
