# Solução — Estado remoto

Dois projetos Terraform nesta pasta:

- **`bootstrap/`** — cria o bucket S3 de state (versionado, criptografado, sem acesso
  público). Testado com `terraform validate` (passa). State local, de propósito.
- **projeto principal** (`versions.tf`, `main.tf`, etc.) — o mesmo da Aula 05, agora com
  `backend "s3"` em `versions.tf`, usando `use_lockfile = true` pro locking nativo. Testado com
  `terraform init -backend=false && terraform validate` (passa — sem tentar conectar a um
  bucket real que ainda não existe neste ambiente).

Ver [`respostas.md`](respostas.md) pro fluxo completo de bootstrap → migração, e pra explicação
de por que o `bootstrap/` fica de fora do backend remoto.

## Nota sobre custo/segurança

`terraform apply` real do `bootstrap/` cria um bucket S3 de verdade na sua conta AWS — dentro
do free tier, mas ainda assim um recurso real. Este repositório não aplica nada automaticamente
— cada aluno roda com as próprias credenciais, no próprio ritmo.
