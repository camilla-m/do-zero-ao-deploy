# Variáveis, outputs e organização de código

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### Variáveis: parametrizando o que muda por ambiente/pessoa

```hcl
variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small"], var.instance_type)
    error_message = "instance_type deve ser t3.micro ou t3.small (mantendo custo baixo pro curso)."
  }
}
```

Três formas de passar valor, em ordem de precedência (a última ganha):
```bash
terraform apply                                    # usa o default
terraform apply -var="instance_type=t3.small"        # via linha de comando
terraform apply -var-file="prod.tfvars"               # via arquivo .tfvars
```
`TF_VAR_instance_type=t3.small terraform apply` também funciona — variável de ambiente com
prefixo `TF_VAR_`. É assim que CI/CD (Módulo 4) injeta valores sem escrever segredo em arquivo.

### Outputs: expondo o que foi criado

```hcl
output "instance_public_ip" {
  description = "IP público da instância"
  value       = aws_instance.minha_vm.public_ip
}
```

Depois de um `apply`, `terraform output` imprime todos os outputs — útil pra pegar um IP,
endpoint ou ARN sem precisar abrir o console. Outputs também são como um módulo Terraform
expõe informação pra quem o está usando (mais sobre módulos, adiante no curso).

### Organização de arquivos (convenção, não regra do Terraform)

O Terraform lê **todos** os `.tf` de uma pasta como se fossem um arquivo só — a divisão abaixo
é só pra legibilidade humana:

```
projeto/
├── versions.tf     # required_providers, required_version
├── providers.tf    # bloco provider
├── variables.tf     # todas as variable
├── main.tf            # os resources
├── outputs.tf          # todos os output
└── terraform.tfvars.example   # exemplo de valores (NUNCA comite o .tfvars real com segredo)
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
