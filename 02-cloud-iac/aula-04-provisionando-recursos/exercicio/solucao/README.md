# Solução — Provisionando recursos com Terraform

```bash
terraform init
terraform validate   # Success! The configuration is valid.
terraform plan -var="meu_ip=203.0.113.10/32"
```

O `plan` mostra 6 resources a criar: `aws_instance`, `aws_security_group`, `random_id`,
`aws_s3_bucket`, `aws_s3_bucket_public_access_block`, `aws_s3_bucket_server_side_encryption_configuration`
— tudo num `apply` só.

## Decisões

- `random_id.bucket_suffix` resolve o problema de nome globalmente único sem exigir que o
  aluno escolha algo criativo — o Terraform gera um sufixo hex determinístico por state,
  estável entre `plan`s (não muda a cada execução).
- Public access block e criptografia por padrão são separados em resources próprios
  (`aws_s3_bucket_public_access_block`, `aws_s3_bucket_server_side_encryption_configuration`)
  porque, no provider AWS 5.x, o recurso `aws_s3_bucket` ficou "burro" de propósito — cada
  aspecto de configuração (versionamento, criptografia, política, CORS...) virou um resource
  separado. É mais verboso, mas deixa claro no `plan` exatamente o que está mudando em cada
  aspecto do bucket.
