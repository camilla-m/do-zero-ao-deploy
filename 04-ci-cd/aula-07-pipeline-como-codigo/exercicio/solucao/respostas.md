# Respostas — Pipeline como código

Execução real depois da extração: https://github.com/camilla-m/do-zero-ao-deploy/actions
(run `35401279661`) — os 3 jobs (`test` via reusable workflow, `build-push`, `deploy`)
passaram, exatamente como antes da refatoração.

## Onde esse reuso economizaria trabalho de verdade

Se este curso tivesse, por exemplo, um segundo serviço no futuro (o projeto final do Módulo 6
poderia muito bem adicionar um segundo microsserviço) escrito também em Python/Flask, o
`ci.yml` dele reusaria o **mesmo** `reusable-test.yml`, só trocando o `working-directory`:

```yaml
test:
  uses: ./.github/workflows/reusable-test.yml
  with:
    working-directory: apps/outro-servico
```

Sem essa extração, qualquer melhoria (trocar a versão do Python, adicionar um linter, mudar o
comando de instalação de dependências) precisaria ser copiada manualmente em cada `ci.yml` — o
mesmo tipo de duplicação que os Helm charts (Módulo 3) resolvem para manifests Kubernetes, mas
agora aplicado à própria definição da pipeline.
