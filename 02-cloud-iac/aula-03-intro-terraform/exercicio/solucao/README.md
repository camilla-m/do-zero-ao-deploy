# Solução — Introdução ao Terraform

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -var="meu_ip=203.0.113.10/32"
```

Testado neste ambiente — `terraform init` e `terraform validate` passam limpos:
```
Success! The configuration is valid.
```

`terraform plan` só funciona com credenciais AWS reais configuradas (`aws configure` ou
variáveis de ambiente) — sem isso, o comando falha na chamada à API pra resolver a `data
"aws_ami"`, o que é esperado.

## Decisões

- `meu_ip` é uma variável, não um valor fixo no código — mesmo antes da Aula 05 (que formaliza
  variáveis/outputs), já vale o hábito de nunca hardcodar algo que muda por pessoa/ambiente.
- `data "aws_ami"` busca a AMI mais recente por filtro de nome, em vez de fixar um ID
  (`ami-0abcd1234...`). IDs de AMI mudam a cada atualização de patch e variam por região — um
  ID fixo quebra silenciosamente com o tempo.
- Egress liberado (`0.0.0.0/0`) é o padrão aceitável pra saída — o que precisa ser restrito é
  sempre a **entrada**.
