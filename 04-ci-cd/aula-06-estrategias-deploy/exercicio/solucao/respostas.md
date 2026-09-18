# Respostas — Estratégias de deploy na prática

## Rolling update observada ao vivo (`kubectl get pods -w`)

```
task-api-665895785-5zt6g   1/1   Running
task-api-665885785-759cf   1/1   Running
task-api-665895785-vc5vb   1/1   Running
task-api-5f879cff54-7m9mf   0/1   Pending              <- pod NOVO (v3) sobe primeiro
task-api-5f879cff54-7m9mf   1/1   Running
task-api-665895785-5zt6g    1/1   Terminating           <- só DEPOIS um pod antigo sai
task-api-5f879cff54-lbc9z   0/1   Pending               <- segundo pod novo
task-api-5f879cff54-lbc9z   1/1   Running
task-api-665895785-vc5vb    1/1   Terminating
task-api-5f879cff54-7sj4w   1/1   Running               <- terceiro pod novo
task-api-665895785-759cf    1/1   Terminating           <- último pod antigo sai por último
```

Confirmado pelo `kubectl rollout status`:
```
Waiting for deployment "task-api" rollout to finish: 1 out of 3 new replicas have been updated...
Waiting for deployment "task-api" rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for deployment "task-api" rollout to finish: 1 old replicas are pending termination...
deployment "task-api" successfully rolled out
```

`curl /health` confirmou `{"status":"ok","version":"v3"}` com a aplicação já na nova versão, em
nenhum momento com **zero** Pods disponíveis.

## Rollback

```bash
$ kubectl rollout undo deployment/task-api
deployment.apps/task-api rolled back
$ kubectl rollout history deployment/task-api
REVISION  CHANGE-CAUSE
2         <none>
3         <none>
```

Depois do undo, `curl /health` voltou a `{"status":"ok"}` (sem `version`) — confirma que voltou
pra imagem anterior. O rollback **também** é uma rolling update (repare que o log de
`rollout status` é idêntico ao do update original) — não é instantâneo, é gradual, na mesma
lógica de segurança de nunca ficar sem capacidade.

## Se `maxUnavailable: 0`

Com `maxUnavailable: 0`, o Kubernetes **nunca** poderia derrubar um Pod antigo antes que um novo
estivesse totalmente pronto substituindo-o — ele seria forçado a depender inteiramente de
`maxSurge` (subir Pods extras, acima do número de réplicas, antes de remover qualquer um
antigo). No log observado, em vez de ver o padrão "sobe 1 novo → derruba 1 antigo → repete",
veríamos primeiro os `maxSurge` Pods extras todos subindo (Ready), e só então os antigos
começando a ser removidos — a contagem total de Pods rodando ficaria temporariamente **acima**
de 3, nunca abaixo. É a configuração certa pra quando "zero indisponibilidade" importa mais que
"não gastar recurso extra temporariamente".
