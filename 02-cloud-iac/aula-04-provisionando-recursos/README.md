# Provisionando recursos com Terraform

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### Resources: o bloco que você mais vai escrever

```hcl
resource "<tipo>" "<nome_local>" {
  argumento = valor
}
```

- `<tipo>` vem do provider (`aws_instance`, `aws_s3_bucket`...) — você não inventa, consulta a
  documentação do provider.
- `<nome_local>` é só uma referência dentro do seu código Terraform — não aparece na AWS.
  Outros recursos referenciam este via `<tipo>.<nome_local>.<atributo>` (ex:
  `aws_security_group.vm_ssh.id`, que você já usou na Aula 03).

### O ciclo plan → apply → destroy, com atenção

```bash
terraform plan -out=tfplan   # calcula o que vai mudar e SALVA o plano num arquivo
terraform apply tfplan        # aplica EXATAMENTE o que foi planejado (sem re-perguntar nada)
terraform destroy             # remove tudo que este projeto criou
```

Usar `-out=tfplan` e aplicar o arquivo salvo (em vez de `terraform apply` direto) é hábito de
produção: garante que o que foi revisado no `plan` é exatamente o que vai ser aplicado — nada
mudou no meio do caminho entre alguém aprovar o plano e ele ser executado (isso importa demais
quando você automatizar isso em CI, no Módulo 4).

### `terraform destroy` não é opcional neste curso

Cada vez que você terminar um exercício com `apply` real, rode `destroy` antes de ir pra
próxima aula. Recursos esquecidos rodando são a causa nº 1 de susto de fatura em quem está
aprendendo cloud.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
