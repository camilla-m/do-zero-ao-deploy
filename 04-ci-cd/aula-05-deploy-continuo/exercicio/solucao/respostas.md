# Respostas — Deploy contínuo até o Kubernetes

Execução real no GitHub Actions: https://github.com/camilla-m/do-zero-ao-deploy/actions

Log real do job `deploy` (step "Smoke test"):
```
Waiting for deployment "redis" rollout to finish: 0 of 1 updated replicas are available...
deployment "redis" successfully rolled out
Waiting for deployment "task-api" rollout to finish: 1 out of 2 new replicas have been updated...
Waiting for deployment "task-api" rollout to finish: 1 old replicas are pending termination...
deployment "task-api" successfully rolled out
Forwarding from 127.0.0.1:8080 -> 5000
Handling connection for 8080
{"status":"ok"}
```

O `curl --fail` retornou sucesso, com o corpo `{"status":"ok"}` — a aplicação, publicada minutos
antes pelo job `build-push`, rodando de verdade num cluster Kubernetes criado do zero pelo
próprio job `deploy`, sem nenhuma intervenção manual entre o `git push` e este resultado.

## Por que o cluster é efêmero, e o que isso prova

O cluster `ci` (criado por `helm/kind-action`) existe **só durante esta execução do job** — a
etapa final (`Post Cria cluster kind`) mostra `Deleting cluster "ci"` automaticamente, assim
que o job termina. Nenhum estado sobrevive de uma execução pra outra.

Isso é exatamente o que dá força ao smoke test: ele não roda contra um cluster que "já estava
configurado do jeito certo" por alguém, em algum momento, manualmente. Ele prova que os
manifests em `k8s/`, sozinhos, sem nenhum passo manual, sobem uma aplicação funcional **do
zero**, toda vez. Se alguém esquecer de commitar um manifest necessário, ou a ordem de
aplicação estiver errada, este job falha — coisa que "funciona na minha máquina, que já tem
tudo criado há meses" nunca vai pegar.
