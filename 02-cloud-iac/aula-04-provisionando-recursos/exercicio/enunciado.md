# Exercício — Provisionando recursos com Terraform

## Objetivo

Partindo do projeto da Aula 03 (VM + Security Group), adicionar um bucket S3 **no mesmo
projeto Terraform** — praticando que um `apply` pode criar vários recursos relacionados de uma
vez.

## Passo a passo

1. Copie o `main.tf` da [Aula 03](../aula-03-intro-terraform/exercicio/solucao/main.tf) (ou o
   seu, se já fez) pra esta pasta.
2. Adicione um `resource "aws_s3_bucket"`. Nomes de bucket S3 são **globalmente únicos** —
   use `random_id` (provider `hashicorp/random`) pra gerar um sufixo, em vez de torcer pra
   ninguém no mundo ter escolhido o mesmo nome.
3. Configure o bucket com boas práticas mínimas:
   - Bloqueie acesso público (`aws_s3_bucket_public_access_block`).
   - Ative criptografia server-side por padrão
     (`aws_s3_bucket_server_side_encryption_configuration`).
4. Rode `terraform plan` — confirme que aparecem os recursos do bucket **junto** com a VM e o
   Security Group (3-4 resources a mais, dependendo de como você contou os sub-recursos do S3).
5. Se for aplicar de verdade: `terraform apply`, confirme os recursos no console, depois
   `terraform destroy`.

## Critério de pronto

- `terraform validate` passa.
- O bucket usa um nome gerado dinamicamente, não uma string fixa.
- Acesso público está bloqueado e criptografia está habilitada.
- `terraform plan` mostra todos os recursos (VM + SG + bucket) no mesmo plano.

## Entrega

Suba `main.tf` (e `random.tf`/outros arquivos, se separar) nesta pasta. Veja
[`solucao/`](solucao/) para referência.
