# Exercício — Estado remoto e trabalho em equipe

## Objetivo

Criar o bucket de state (bootstrap), migrar o projeto da Aula 05 pra usá-lo como backend, e
confirmar que o state deixou de existir localmente.

## Passo a passo

1. Crie uma pasta `bootstrap/` com um projeto Terraform **separado**, com state local mesmo,
   que cria:
   - Um `aws_s3_bucket` pro state, com **versionamento habilitado** (se o state corromper, dá
     pra voltar a uma versão anterior).
   - `aws_s3_bucket_server_side_encryption_configuration` habilitando criptografia.
   - `aws_s3_bucket_public_access_block` bloqueando acesso público.
2. Se tiver credenciais AWS reais: `cd bootstrap && terraform init && terraform apply`. Anote o
   nome do bucket criado (via `output`).
3. Copie os arquivos do projeto da [Aula 05](../aula-05-variaveis-outputs/exercicio/solucao/)
   pra esta pasta (fora do `bootstrap/`).
4. Em `versions.tf`, adicione o bloco `backend "s3"` apontando pro bucket criado no passo 1-2,
   com `use_lockfile = true`.
5. Rode `terraform init` — se já existia state local, o Terraform pergunta se quer migrar pro
   novo backend; confirme.
6. Confirme que não sobrou nenhum `terraform.tfstate` local no projeto principal (só no
   `bootstrap/`, que continua com state local mesmo, de propósito).

## Critério de pronto

- `bootstrap/` tem seu próprio projeto Terraform, com `terraform validate` passando.
- O projeto principal tem o bloco `backend "s3"` com `use_lockfile = true`.
- `respostas.md` explica por que o `bootstrap/` continua usando state **local** enquanto todo o
  resto migrou pra remoto (é sobre o problema do ovo e da galinha, descrito no roteiro).

## Entrega

Suba `bootstrap/` e o projeto principal atualizado nesta pasta, junto com `respostas.md`. Veja
[`solucao/`](solucao/) para referência.
