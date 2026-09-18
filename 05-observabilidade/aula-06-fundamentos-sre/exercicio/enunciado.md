# Exercício — Fundamentos de SRE

## Objetivo

Definir um SLO real pra `task-api`, calcular o error budget correspondente, e escrever uma
regra Prometheus que meça o SLI na prática.

## Passo a passo

1. Escolha um SLI pra `task-api`: sugestão — **disponibilidade**, medida como "% de
   requisições que NÃO retornam 5xx", usando as métricas que você já tem
   (`task_api_requests_total`).
2. Defina um SLO pra esse SLI — um número específico (ex: 99%, 99.5%, 99.9%) — e **justifique**:
   por que esse número, e não mais frouxo ou mais rígido? (Pense no contexto: é uma API de
   estudo, não um sistema de pagamento — qual rigor faz sentido?)
3. Calcule o error budget correspondente, em **minutos por mês** (considere um mês de 30 dias =
   43.200 minutos).
4. Escreva a query PromQL que mede seu SLI na janela de 30 dias:
   ```promql
   1 - (
     sum(increase(task_api_requests_total{status=~"5.."}[30d]))
     /
     sum(increase(task_api_requests_total[30d]))
   )
   ```
5. (Opcional, se seu cluster ainda tiver dados de mais de alguns minutos) Rode a query no
   Prometheus e veja o valor atual — mesmo que a janela de 30 dias ainda não tenha completado.

## Critério de pronto

- `respostas.md` com: o SLI escolhido, o SLO com justificativa, o error budget em minutos/mês,
  e a query PromQL.

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para uma referência.
