# Primeiros passos no provedor de nuvem

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### Por que começar pelo console, se o curso é sobre Infraestrutura como Código?

Porque clicar antes de automatizar ensina o que o Terraform vai fazer por baixo dos panos. Se
você nunca viu os campos de um formulário de criação de VM no console, o `main.tf` da próxima
aula vai parecer mágica em vez de "isso aqui é só automatizar o que eu já cliquei".

### Criando a conta e entendendo a camada gratuita

1. Crie uma conta na AWS em [aws.amazon.com](https://aws.amazon.com) — precisa de cartão de
   crédito, mesmo pra usar só o free tier (é verificação de identidade, não cobrança).
2. **Ative alertas de billing antes de criar qualquer recurso**: Billing → Billing Preferences
   → marque "Receive Billing Alerts". Depois crie um alarme no CloudWatch pra ser avisado se o
   gasto passar de US$ 1.
3. O free tier da AWS cobre, entre outras coisas: 750h/mês de EC2 `t2.micro`/`t3.micro` (12
   primeiros meses), 5GB de S3, sempre. É suficiente pra tudo que você vai fazer neste curso —
   mas **crie o hábito de destruir recursos que não está usando** (a Aula 04 já ensina o
   `terraform destroy`).

### Navegando no console

- **Região**: sempre visível no canto superior direito. Escolha uma e mantenha consistência —
  `us-east-1` é a mais barata/completa na maioria dos serviços.
- **IAM**: nunca use a conta root pro dia a dia. Crie um usuário IAM pra você mesmo, com uma
  política de permissões (neste curso, `AdministratorAccess` é aceitável pra aprender, mas em
  produção real isso seria escopo demais).
- **EC2**: onde vivem as máquinas virtuais.
- **VPC**: onde vive a rede (Módulo 2, Aula 07).
- **S3**: armazenamento de objetos.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
