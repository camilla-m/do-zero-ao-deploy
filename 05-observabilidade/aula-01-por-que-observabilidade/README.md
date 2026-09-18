# Por que observabilidade importa

**Módulo:** Módulo 5 — Observabilidade
**Duração:** ~1h

## Roteiro

### "Está no ar" não é a mesma pergunta que "está saudável"

Até aqui, você confirmou que a `task-api` funciona rodando um `curl` manualmente. Isso prova
que funcionou **naquele instante, pra você**. Em produção, ninguém fica rodando `curl` toda
hora — você precisa que o **sistema te conte** quando algo vai mal, antes que um usuário
reclame. Essa é a diferença entre "funciona" (uma checagem pontual) e observabilidade (um fluxo
contínuo de sinal sobre o que está acontecendo).

### Os três pilares

```
Métricas          Logs                    Traces
(números ao       (eventos discretos,      (o caminho de UMA requisição
 longo do tempo)   com contexto)            através de vários serviços)

"quantos          "às 14:32:07, o          "esta requisição específica
 requests/s?       usuário X tentou         levou 800ms: 20ms na API,
 qual a latência   criar uma tarefa e       750ms esperando o Redis,
 p99?"             recebeu 400 porque      30ms formatando resposta"
                   title estava vazio"
```

- **Métricas**: baratas de guardar, ótimas pra ver tendência e disparar alerta ("erro 5xx subiu
  de 0.1% pra 8% nos últimos 5 minutos"), mas não contam a história de uma requisição
  específica. Este módulo foca aqui: **Prometheus** (Aula 02) coleta, **Grafana** (Aula 03)
  visualiza, alertas (Aula 04) avisam.
- **Logs**: contam o que aconteceu, com detalhe, mas são caros de guardar e buscar em volume
  alto, e sozinhos não mostram tendência. Aula 05 trata de centralizá-los.
- **Traces**: mostram o caminho de uma requisição por múltiplos serviços — essencial em
  arquiteturas com muitos microsserviços conversando entre si. Fica fora do escopo hands-on
  deste curso (a `task-api` é um serviço só), mas vale saber que existe pra quando a
  arquitetura crescer.

### A pergunta que guia este módulo inteiro

Não é "quais ferramentas de observabilidade existem" — é **"se a `task-api` cair às 3h da
manhã, como alguém saberia, e como essa pessoa descobriria por quê, sem acordar o time
inteiro pra investigar no escuro?"**. Cada aula deste módulo responde um pedaço dessa pergunta.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
