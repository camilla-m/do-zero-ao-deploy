# Solução — Rede na nuvem via código

```bash
terraform fmt
terraform init
terraform validate   # Success! The configuration is valid.
```

`terraform plan` de verdade (com credenciais reais) mostra:
- **`criar_nat_gateway = false`** (padrão): 8 resources — VPC, 2 subnets, IGW, 2 route tables, 2
  associations. **Nenhum** NAT Gateway ou Elastic IP.
- **`criar_nat_gateway = true`**: os mesmos 8, mais `aws_eip.nat` e `aws_nat_gateway.curso` e a
  rota extra na tabela privada — 3 resources a mais.

Isso não foi testado com `apply` real neste ambiente (sem credenciais AWS configuradas), mas
`terraform validate` confirma que a sintaxe e os tipos estão corretos, incluindo o uso
condicional (`count = var.criar_nat_gateway ? 1 : 0`).

## Decisões

- `count` em vez de módulo separado pro NAT — pra um recurso opcional simples como este, `count`
  com uma variável booleana é mais direto que a alternativa (módulo com `for_each`, ou
  duplicar o projeto inteiro).
- `data "aws_availability_zones"` busca AZs disponíveis dinamicamente, em vez de fixar
  `us-east-1a` — AZs disponíveis variam por conta AWS (algumas contas mais antigas não têm
  acesso a todas).
- As duas subnets ficam na **mesma** AZ de propósito, pra manter o exercício simples — em
  produção real, você distribuiria subnets entre múltiplas AZs pra alta disponibilidade (mais
  sobre isso quando o cluster Kubernetes entrar em cena, no Módulo 3).
