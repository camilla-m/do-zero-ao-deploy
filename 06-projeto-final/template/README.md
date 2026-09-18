# Template — Projeto Final

Use esta pasta como esqueleto inicial pro seu projeto: copie `template/` inteira pra fora deste
repositório (ou pra um repositório novo seu) e comece a preencher.

```
meu-projeto-final/
├── README.md              # preencha ao final: o que a app faz, arquitetura, decisões
├── infra/                  # Terraform -- ver infra/main.tf
├── app/                     # código da sua aplicação
├── k8s/                      # manifests ou Helm chart -- ver k8s/deployment.yaml
├── .github/
│   └── workflows/
│       └── ci.yml              # pipeline -- ver o exemplo comentado
└── observabilidade/
    └── dashboards/
        └── dashboard.json        # exportado do Grafana, como na Módulo 5 Aula 03
```

## Por onde começar

1. Escreva a aplicação em `app/` primeiro, rodando **localmente**, antes de tocar em Terraform
   ou Kubernetes — se ela não funciona na sua máquina, não vai funcionar containerizada.
2. `infra/main.tf` tem um esqueleto comentado com os recursos mínimos esperados (rede + onde a
   aplicação vai rodar) — adapte, não precisa usar exatamente essa estrutura.
3. `k8s/deployment.yaml` segue o mesmo padrão usado no curso inteiro (Módulo 3) — ajuste nome,
   imagem, porta.
4. `.github/workflows/ci.yml` tem os jobs `test`/`build-push`/`deploy` comentados, no mesmo
   formato do `ci.yml` deste repositório — preencha os `working-directory` e comandos reais da
   sua aplicação.
5. `observabilidade/` fica vazia até você ter a aplicação rodando no cluster e conseguir
   instrumentá-la — normalmente a última peça a entrar, não a primeira.

Cada arquivo `.tf`/`.yaml` desta pasta tem comentários `# TODO:` marcando o que é específico do
seu projeto — o resto já é a estrutura que o curso usou o tempo inteiro.
