# Exercício — Rede na nuvem via código

## Objetivo

Criar, via Terraform, uma VPC isolada com uma subnet pública e uma privada — a base de rede que
o Módulo 3 vai usar pra hospedar o cluster Kubernetes.

## Passo a passo

Crie um projeto Terraform novo nesta pasta com:

1. Uma `aws_vpc` com CIDR `10.0.0.0/16` e DNS support habilitado.
2. Uma `aws_subnet` pública, CIDR `10.0.1.0/24`, `map_public_ip_on_launch = true`.
3. Uma `aws_subnet` privada, CIDR `10.0.2.0/24`.
4. Um `aws_internet_gateway` anexado à VPC.
5. Uma `aws_route_table` pública, com rota `0.0.0.0/0` pro Internet Gateway, associada à subnet
   pública.
6. Uma `aws_route_table` privada, **sem** rota pra internet, associada à subnet privada.
7. Um NAT Gateway **opcional**, controlado por `variable "criar_nat_gateway" { default = false
   }` — só cria o `aws_nat_gateway` (e a rota da subnet privada até ele) se a variável for
   `true`. Documente no `README.md` da sua solução o custo aproximado de deixar ligado.

## Critério de pronto

- `terraform validate` passa.
- Com `criar_nat_gateway = false` (o padrão), o plano **não** inclui NAT Gateway nem Elastic
  IP.
- `terraform plan -var="criar_nat_gateway=true"` mostra o NAT Gateway sendo criado.
- Outputs expõem o ID da VPC e os IDs das duas subnets.

## Entrega

Suba os arquivos `.tf` nesta pasta. Veja [`solucao/`](solucao/) para referência.
