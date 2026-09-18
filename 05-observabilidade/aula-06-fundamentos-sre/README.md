# Fundamentos de SRE

**Módulo:** Módulo 5 — Observabilidade
**Duração:** ~1h

## Roteiro

### SLI, SLO, SLA — três siglas parecidas, três coisas diferentes

- **SLI** (Service Level *Indicator*): uma métrica que você já sabe medir agora, graças às
  Aulas 02-05 — ex: "% de requisições que respondem com sucesso", "latência p95".
- **SLO** (Service Level *Objective*): a meta interna que você define pra esse indicador — ex:
  "99.5% das requisições bem-sucedidas, medido por mês". É um alvo pra guiar decisão, não uma
  promessa pra fora.
- **SLA** (Service Level *Agreement*): um SLO que virou **compromisso contratual**, geralmente
  com consequência financeira se não for cumprido — normalmente mais frouxo que o SLO interno,
  de propósito (dá margem antes de virar problema contratual).

Você já tem os SLIs prontos (as métricas do Prometheus); esta aula é sobre transformar isso numa
meta com significado.

### Error budget: o orçamento de falha que sua meta permite

Se o SLO é "99.5% de sucesso por mês", o **error budget** é o inverso: **0.5%** de requisições
podem falhar sem violar a meta. Em números: num mês com ~2.6 milhões de segundos, um SLO de
disponibilidade de 99.5% permite pouco mais de **3.6 horas** de indisponibilidade total.

O error budget muda a conversa de time: em vez de "zero falha, sempre" (impossível, e
paralisante — ninguém arrisca deploy nenhum), a pergunta vira "quanto do nosso orçamento de
falha já gastamos este mês, e isso muda quão arriscado um deploy pode ser hoje?".

### Cultura blameless

Quando um incidente acontece, o objetivo do post-mortem é entender **a cadeia de causas** (o
que o sistema/processo permitiu que desse errado), não achar **uma pessoa** pra culpar.
Na prática: post-mortems documentam decisões que fizeram sentido no momento, com a informação
disponível então — culpar a pessoa ensina o time a esconder erro, não a preveni-lo. Isso
conecta direto com hábitos que você já praticou: Pull Request com revisão (Módulo 1), pipeline
de CI barrando código quebrado (Módulo 4) — a meta é sistema que **previne** erro comum, não
heroísmo individual.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
