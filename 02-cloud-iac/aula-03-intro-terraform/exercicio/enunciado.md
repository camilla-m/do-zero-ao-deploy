# Exercício — Introdução ao Terraform

## Objetivo

Recriar via Terraform a mesma VM que você criou manualmente na Aula 02: uma instância EC2
`t3.micro`, com um Security Group liberando SSH só pro seu IP.

## Passo a passo

1. Crie um `main.tf` nesta pasta com:
   - O bloco `terraform { required_providers { aws = ... } }` e `provider "aws"`.
   - Uma `data "aws_ami"` que busca a AMI mais recente do Amazon Linux 2023 (não fixe um ID de
     AMI na mão — eles mudam por região e ficam desatualizados).
   - Um `aws_security_group` liberando porta 22 de entrada só do seu IP, e todo tráfego de
     saída.
   - Um `aws_instance` usando a AMI encontrada e o Security Group criado.
2. Rode o ciclo:
   ```bash
   terraform init
   terraform fmt
   terraform validate
   terraform plan
   ```
3. Se tiver credenciais AWS configuradas e quiser aplicar de verdade: `terraform apply`, depois
   `terraform destroy` ao terminar. **Se não tiver conta AWS configurada ainda, tudo bem** — o
   objetivo desta aula é `validate`/`plan` passarem sem erro; aplicar de fato é opcional.

## Critério de pronto

- `terraform validate` passa sem erro.
- `terraform plan` mostra a criação de 1 `aws_security_group` e 1 `aws_instance` (mesmo sem
  aplicar — o `plan` funciona só com credenciais válidas, mesmo sem nunca ter criado nada).
- A porta 22 do Security Group está restrita a um IP específico, não a `0.0.0.0/0`.

## Entrega

Suba `main.tf` nesta pasta. Veja [`solucao/`](solucao/) para uma referência testada com
`terraform validate`.
