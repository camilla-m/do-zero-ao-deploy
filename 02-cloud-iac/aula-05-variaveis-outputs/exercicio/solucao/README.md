# Solução — Variáveis, outputs e organização de código

```bash
terraform init
terraform validate   # Success! The configuration is valid.

# testando a validation customizada:
terraform plan -var="meu_ip=203.0.113.10/32" -var="instance_type=t3.large"
```
```
Error: Invalid value for variable
  instance_type deve ser t3.micro ou t3.small (mantendo custo baixo pro curso).
```
A validação dispara **antes** de qualquer chamada à AWS — funciona mesmo sem credenciais
configuradas, porque é uma checagem estática sobre o valor da variável.

## Decisões

- `versions.tf`/`providers.tf`/`variables.tf`/`main.tf`/`outputs.tf` — mesmos nomes que times
  reais usam. O Terraform não exige essa separação (ele lê a pasta inteira como um arquivo só),
  mas seguir a convenção facilita quem chega depois de você achar as coisas.
- `terraform.tfvars.example` fica versionado; `terraform.tfvars` real fica no `.gitignore` (ver
  raiz do repositório) — o padrão de "exemplo comitado, valor real ignorado" se repete em
  praticamente todo projeto que usa segredo ou dado específico de ambiente.
- Outputs devolvem só o que é útil de consultar depois (IP, nome e ARN do bucket) — não é
  preciso expor todo atributo de todo resource.
