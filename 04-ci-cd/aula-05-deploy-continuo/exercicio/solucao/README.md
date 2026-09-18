# Solução — Deploy contínuo até o Kubernetes

O job `deploy` fica em `.github/workflows/ci.yml`, na raiz do repositório (terceiro job, depois
de `test` e `build-push`). Os manifests ficam em `k8s/`, também na raiz — a partir desta aula,
são eles que a pipeline real usa.

Ver [`respostas.md`](respostas.md) para o resultado observado na execução real do GitHub
Actions.
