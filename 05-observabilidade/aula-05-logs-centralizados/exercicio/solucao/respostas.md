# Respostas — Logs centralizados

## Query usada

```bash
curl -G 'http://localhost:3100/loki/api/v1/query_range' \
  --data-urlencode 'query={app="task-api"}' \
  --data-urlencode 'limit=10' \
  --data-urlencode "start=<300s atras, em nanosegundos>" \
  --data-urlencode "end=<agora, em nanosegundos>"
```

(A mesma query, `{app="task-api"}`, funciona idêntica em Grafana → Explore → datasource Loki.)

## Antes de matar os Pods

```
labels: {app: task-api, filename: .../task-api-6d878ffd-tbs92_.../task-api/0.log, ...}
  "GET /health HTTP/1.1" 200
  "GET /metrics HTTP/1.1" 200
labels: {app: task-api, filename: .../task-api-6d878ffd-xpr6g_.../task-api/0.log, ...}
  "GET /metrics HTTP/1.1" 200
```

## Depois de `kubectl delete pod -l app=task-api`

Pods novos: `task-api-6d878ffd-8cxnn`, `task-api-6d878ffd-wmksv`.

Repetindo a mesma query `{app="task-api"}`, os **4** streams aparecem juntos — os dois Pods
antigos (`tbs92`, `xpr6g`, já removidos do cluster) e os dois novos:

```
/var/log/pods/default_task-api-6d878ffd-8cxnn_.../task-api/0.log   <- novo
/var/log/pods/default_task-api-6d878ffd-wmksv_.../task-api/0.log   <- novo
/var/log/pods/default_task-api-6d878ffd-tbs92_.../task-api/0.log   <- pod ja morto
/var/log/pods/default_task-api-6d878ffd-xpr6g_.../task-api/0.log   <- pod ja morto
```

`kubectl logs task-api-6d878ffd-tbs92` já retornaria erro (`pods "task-api-...tbs92" not
found`) — mas o log continua consultável no Loki, porque o Promtail já tinha lido e enviado
essas linhas **antes** do Pod ser removido. É exatamente a lacuna que a Aula 01 identificou.

## Sobre a descoberta automática (kubernetes_sd_configs)

Testado, e documentado no `promtail-configmap.yaml`: a versão "de livro" com
`kubernetes_sd_configs` (mesmo padrão usado no Prometheus, Aula 02) simplesmente não descobriu
nenhum target neste ambiente — `0/0 active targets`, em duas versões diferentes da imagem do
Promtail, mesmo com RBAC correto e a API do Kubernetes respondendo normalmente a chamadas
manuais com o mesmo token. Não foi possível isolar a causa raiz em tempo hábil dentro desta
aula. A solução usa `static_configs` com um glob de path — funciona, é mais simples de
entender, e é uma limitação real de ferramenta que vale documentar (nem toda "melhor prática"
funciona de primeira em todo ambiente — descobrir isso rápido e ter um plano B é uma habilidade
tão importante quanto configurar a ferramenta em si).
