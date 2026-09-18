# Exercício — Variáveis, outputs e organização de código

## Objetivo

Refatorar o projeto da Aula 04 (VM + bucket) separando em `versions.tf`, `providers.tf`,
`variables.tf`, `main.tf` e `outputs.tf` — sem mudar o que é criado, só a organização —, e
adicionar outputs úteis.

## Passo a passo

1. Copie o `main.tf` da [Aula 04](../aula-04-provisionando-recursos/exercicio/solucao/main.tf)
   pra esta pasta.
2. Separe o conteúdo em:
   - `versions.tf`: bloco `terraform { required_providers { ... } }`.
   - `providers.tf`: bloco `provider "aws"`.
   - `variables.tf`: todas as `variable`, incluindo `meu_ip` (que já existia) e uma nova,
     `instance_type`, com `default = "t3.micro"` e uma `validation` restringindo a
     `t3.micro`/`t3.small`.
   - `main.tf`: só os `resource` e `data`.
   - `outputs.tf`: novo arquivo com pelo menos 3 outputs: IP público da instância, nome do
     bucket, e ARN do bucket.
3. Crie `terraform.tfvars.example` com um exemplo de `meu_ip` (não um IP real seu).
4. Rode `terraform validate` e `terraform plan` — o comportamento deve ser idêntico ao da Aula
   04, só a organização do código mudou.

## Critério de pronto

- `terraform validate` passa.
- A variável `instance_type` tem `validation` funcionando — teste passando um valor inválido
  (`terraform plan -var="instance_type=t3.large"`) e confirme que o Terraform recusa com a
  mensagem de erro customizada.
- `terraform output` (depois de um `apply`, se você aplicar de verdade) mostra os 3 outputs.

## Entrega

Suba os arquivos `.tf` e o `terraform.tfvars.example` nesta pasta. Veja
[`solucao/`](solucao/) para referência.
