# Introdução ao Terraform

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### Por que Infraestrutura como Código

Tudo que você clicou na Aula 02 — some se você esquecer os passos, não tem histórico de quem
mudou o quê, e não dá pra revisar em um Pull Request. Infraestrutura como código resolve as
três coisas: o `.tf` é a fonte da verdade, versionada no Git, revisável como qualquer código.

### Instalando o Terraform

```bash
# macOS
brew install terraform

# verifica
terraform --version
```

### Provider: a ponte entre Terraform e a nuvem

Um **provider** é um plugin que sabe conversar com a API de um serviço específico (AWS, GCP,
Kubernetes...). Todo projeto Terraform começa declarando qual(is) provider(s) ele usa:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

O Terraform autentica na AWS do mesmo jeito que o AWS CLI: variáveis de ambiente
(`AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY`) ou o arquivo `~/.aws/credentials` criado por
`aws configure`. Nunca coloque credenciais dentro de um arquivo `.tf`.

### O ciclo de vida básico

```bash
terraform init      # baixa os providers declarados
terraform fmt        # formata o código no padrão HCL
terraform validate   # checa erro de sintaxe/tipo, sem tocar em nada real
terraform plan        # mostra o que MUDARIA, sem aplicar
terraform apply        # aplica de verdade (pede confirmação)
terraform destroy       # desfaz tudo que foi criado por este projeto
```

`plan` é o comando que você roda 100x mais que `apply` — é o "modo leitura" que te deixa
revisar antes de mexer em recursos reais.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
