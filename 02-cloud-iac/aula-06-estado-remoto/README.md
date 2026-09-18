# Estado remoto e trabalho em equipe

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### O que é o `terraform.tfstate`, e por que ele é perigoso local

O state é o arquivo onde o Terraform guarda o mapeamento entre o seu código e os recursos reais
que existem na AWS — é assim que ele sabe o que já existe, o que mudou, e o que precisa
destruir. Sem ele, o Terraform não tem memória nenhuma.

Guardar o state **local** (o padrão, se você não configurar nada) tem três problemas sérios:

1. **Ninguém mais no time consegue rodar `terraform apply`** sem esse arquivo específico — ele
   vive só na sua máquina.
2. **Sem lock**: se duas pessoas rodarem `apply` ao mesmo tempo, cada uma achando que tem a
   verdade, dá corrupção de state ou recursos duplicados.
3. **Pode conter segredo em texto plano** — senhas geradas, chaves privadas — e é comum
   `terraform.tfstate` acabar commitado sem querer num repositório público.

### Backend remoto: state compartilhado, com lock

Um **backend** define onde o state vive. Pra AWS, o padrão é guardar num bucket S3, com
**locking** pra impedir dois `apply` simultâneos:

```hcl
terraform {
  backend "s3" {
    bucket       = "meu-bucket-de-tfstate"
    key          = "do-zero-ao-deploy/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true   # locking nativo do backend S3 (Terraform 1.10+) — não precisa de DynamoDB
  }
}
```

`use_lockfile = true` é a forma atual (Terraform 1.10+): o próprio S3 guarda um arquivo de
lock ao lado do state. Versões mais antigas do Terraform (e a maioria dos tutoriais que você
vai achar por aí) usam uma tabela DynamoDB separada pra isso — funciona, mas é uma peça a mais
pra manter. Vale saber que existe, porque você vai encontrar em projetos legados.

### O problema do ovo e da galinha

Você não pode guardar o state do seu projeto num bucket S3... que ainda não existe. A solução
padrão: um projeto Terraform **separado e mínimo** (`bootstrap/`), que cria só o bucket de
state (com state **local**, só dele), rodado uma vez. Depois disso, todo o resto do curso usa
esse bucket como backend.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
