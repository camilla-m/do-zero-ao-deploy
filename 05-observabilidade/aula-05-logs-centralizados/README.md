# Logs centralizados

**Módulo:** Módulo 5 — Observabilidade
**Duração:** ~1h

## Roteiro

### O problema que `kubectl logs` não resolve

`kubectl logs <pod>` funciona — enquanto o Pod existir. Assim que ele é recriado (Módulo 3,
Aula 06 — todo Pod é descartável), o log antigo **some** com ele. Investigar "o que aconteceu
ontem às 14h" (o cenário da Aula 01 deste módulo) exige logs guardados **fora** do ciclo de
vida de qualquer Pod específico.

### Padrão: agente coletor + armazenamento central + consulta

```
Pod A (stdout) ─┐
Pod B (stdout) ─┼──► Agente (DaemonSet, 1 por node) ──► Armazenamento central ──► Consulta
Pod C (stdout) ─┘        lê os arquivos de log do          (Loki, Elasticsearch,       (LogQL,
                          node inteiro                       CloudWatch Logs...)        query)
```

- **DaemonSet**: diferente de um Deployment (N réplicas, o Kubernetes decide onde), um
  DaemonSet garante **exatamente um Pod por node**, sempre — o padrão certo pra um agente que
  precisa ler os logs de *todos* os containers daquele node, não competir por um subconjunto.
- Containers no Kubernetes escrevem log em **stdout/stderr** (não em arquivo dentro do
  container) — o runtime do container já redireciona isso pra um arquivo no node, que o agente
  lê. É por isso que a `task-api` nunca precisou de configuração de log especial: o
  `print`/log do Flask já vai pra stdout por padrão.

### Grafana Loki: like Prometheus, mas pra logs

Este curso usa **Loki** por já reaproveitar o Grafana (Aula 03) como interface de consulta —
mesma ferramenta, uma aba a mais. Loki indexa só **labels** (não o texto inteiro de cada linha,
como Elasticsearch faz) — mais barato de operar, à custa de busca por texto livre ser um pouco
mais lenta. Pra volume de log de um curso, a diferença não importa; em produção de verdade, é
uma escolha real de trade-off.

```logql
{app="task-api"}                          # todos os logs do app
{app="task-api"} |= "ERROR"                # filtra por texto
{app="task-api"} | json | status >= 500     # se o log for JSON estruturado, filtra por campo
```

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
