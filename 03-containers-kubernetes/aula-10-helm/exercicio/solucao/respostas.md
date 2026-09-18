# Respostas — Helm

```bash
helm template task-api-chart          # renderiza sem instalar -- conferido, gera Deployment,
                                        # Service e ConfigMap válidos (ver saída completa no
                                        # README desta pasta)

helm install task-api-release ./task-api-chart
# STATUS: deployed, REVISION: 1
```

## Upgrade mudando réplicas

```bash
# values.yaml: replicaCount: 2 -> 3
helm upgrade task-api-release ./task-api-chart
```
```
Release "task-api-release" has been upgraded. Happy Helming!
REVISION: 2
```
```bash
$ kubectl get pods -l app=task-api
NAME                       READY   STATUS    AGE
task-api-665895785-5zt6g   1/1     Running   15s
task-api-665895785-759cf   1/1     Running   3s
task-api-665895785-vc5vb   1/1     Running   15s
```
3 Pods rodando, sem eu ter tocado em nenhum outro arquivo além de `values.yaml`.

## Por que o Secret ficou de fora do chart

`values.yaml` é um arquivo de texto puro, normalmente **commitado no Git** junto com o resto do
chart — colocar `REDIS_URL` (ou qualquer credencial) lá dentro seria o mesmo erro de escrever
segredo direto no `deployment.yaml`, só que agora reutilizável e versionado.

O padrão usado aqui (`secretName` como referência de **nome**, não de conteúdo) é comum em
Helm charts reais: o chart assume que o Secret existe no cluster — criado separadamente, por
`kubectl apply` manual, por uma ferramenta de gestão de segredos (Vault, External Secrets
Operator, Sealed Secrets), ou por um processo de CI/CD com acesso a um cofre — e só referencia
o **nome** dele. O chart nunca precisa saber o conteúdo.
