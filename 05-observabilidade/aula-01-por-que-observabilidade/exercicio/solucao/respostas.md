# Respostas — Por que observabilidade importa

## 1. Taxa de erro subindo de repente

Hoje: **não**, a menos que eu esteja olhando `kubectl logs` naquele exato momento, ou algum
usuário reclame. Não existe nenhum sinal ativo — pilar que resolve: **métricas** (Aula 02,
Prometheus conta requisições por status HTTP) + **alertas** (Aula 04, avisa sem eu precisar
estar olhando).

## 2. Reclamação de usuário sobre ontem às 14h

Hoje: só parcialmente. `kubectl logs` mostra saída do processo, mas **não sobrevive** a um Pod
sendo recriado (Módulo 3, Aula 06 — logs de um Pod morto somem com ele) — se o Pod daquele
momento já não existe mais, a informação já se perdeu. Pilar que resolve: **logs
centralizados** (Aula 05), guardados fora do ciclo de vida do Pod.

## 3. Memory leak gradual

Hoje: só descobriria **depois**, pelo restart do container (`kubectl get pods` mostraria
`RESTARTS` incrementado, e eventualmente um `OOMKilled` no `describe pod`) — nunca vendo a
tendência crescente chegando lá. Pilar que resolve: **métricas** (Aula 02) com uma série
temporal de uso de memória, que mostraria a curva subindo dias antes do problema estourar.

## Resumo — pilar × aula

| Pergunta | Pilar | Aula que resolve |
|---|---|---|
| 1. Erro subindo | Métricas + Alertas | Aula 02 (Prometheus) + Aula 04 (Alertas) |
| 2. Reclamação passada | Logs | Aula 05 (Logs centralizados) |
| 3. Memory leak gradual | Métricas | Aula 02 (Prometheus) + Aula 03 (visualizar tendência no Grafana) |

O fio comum: hoje, tudo depende de **alguém estar olhando no momento certo**, ou de informação
que já sumiu. Observabilidade é trocar "só sei se eu tiver sorte de estar olhando" por "o
sistema me avisa, e eu consigo investigar depois, mesmo que o Pod que causou o problema já não
exista mais".
