# Respostas — Fundamentos de SRE

## SLI escolhido

**Disponibilidade**: percentual de requisições que **não** retornam erro de servidor (5xx),
sobre o total de requisições, medido numa janela de 30 dias.

## SLO e justificativa

**99% de disponibilidade por mês.**

Por quê 99% e não 99.9%: a `task-api` é uma aplicação de estudo, rodando num cluster local de
um único node, sem redundância geográfica, sem banco gerenciado com replicação — um SLO de
99.9% (padrão comum de serviços pagos críticos) exigiria infraestrutura que este projeto
simplesmente não tem (múltiplas réplicas em múltiplas AZs, banco gerenciado, etc. — o Módulo 6
integra o que já existe, não adiciona essa complexidade). 99% é um número que reflete o que a
arquitetura atual **realisticamente consegue sustentar**, sem forçar decisões desproporcionais
ao contexto (ex: paginar alguém às 3h por um SLO fantasioso demais).

Por quê não mais frouxo (ex: 95%): mesmo sendo um projeto de estudo, 95% permitiria quase 36h
de indisponibilidade por mês sem violar a meta — frouxo demais pra servir de sinal útil de
"algo está errado".

## Error budget

```
Mês de 30 dias = 30 × 24 × 60 = 43.200 minutos
SLO de 99% de disponibilidade → até 1% de indisponibilidade permitida

Error budget = 43.200 × 0.01 = 432 minutos/mês  (= 7,2 horas/mês)
```

## Query PromQL do SLI

```promql
1 - (
  sum(increase(task_api_requests_total{status=~"5.."}[30d]))
  /
  sum(increase(task_api_requests_total[30d]))
)
```

`increase()` (não `rate()`) porque queremos o **total acumulado** de eventos na janela, não uma
taxa por segundo — faz mais sentido pra um cálculo de "quantas das requisições totais deram
erro", que é uma razão de contagens, não de taxas.

## Conectando com o resto do módulo

Esse SLO é exatamente o tipo de limiar que uma regra de alerta (Aula 04) deveria vigiar — em vez
de alertar em "1 erro isolado", um alerta de **burn rate** dispararia quando o ritmo de consumo
do error budget indicasse que, se continuar naquele ritmo, o orçamento do mês inteiro estoura
antes do fim do mês. Implementar isso de verdade é um passo além do escopo hands-on desta aula,
mas é o próximo degrau natural depois de "alertar em falha simples".
