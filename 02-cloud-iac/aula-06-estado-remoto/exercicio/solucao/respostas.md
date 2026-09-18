# Respostas — Estado remoto

## Por que `bootstrap/` continua com state local

Porque o backend remoto do projeto principal é **um bucket S3** — e esse bucket só existe
depois que alguém roda um `terraform apply`. Se o `bootstrap/` também usasse backend remoto,
seria preciso um bucket pra guardar o state do projeto que cria o bucket — um ciclo sem fim.

A solução padrão da indústria é exatamente separar em dois projetos: um mínimo e raramente
tocado (`bootstrap/`, state local, roda uma vez e praticamente nunca muda de novo) que cria só
a infraestrutura de suporte (bucket de state), e o projeto principal, que já nasce usando esse
bucket como backend.

## Fluxo completo

```bash
# 1. cria o bucket de state (uma vez só)
cd bootstrap
terraform init
terraform apply -var="bucket_name=do-zero-ao-deploy-tfstate-<seu-sufixo>"
terraform output bucket_name

# 2. usa o bucket criado no backend do projeto principal
cd ..
# edita versions.tf: troca "do-zero-ao-deploy-tfstate-SEUSUFIXO" pelo nome real do output acima
terraform init
# Terraform detecta state local existente e pergunta se quer migrar -> "yes"

# 3. confirma
ls terraform.tfstate 2>/dev/null && echo "ainda tem state local (errado)" || echo "state migrado com sucesso"
```
