# Alertas

**Módulo:** Módulo 5 — Observabilidade
**Duração:** ~1h

## Roteiro

### De "dashboard que alguém precisa estar olhando" pra "o sistema me avisa"

Um dashboard bonito não serve de nada às 3h da manhã se ninguém está olhando. **Alertmanager**
(o componente de alertas do ecossistema Prometheus) resolve isso: você declara **regras** —
condições sobre as mesmas métricas que já existem — e, quando uma regra fica verdadeira por
tempo suficiente, alguém (ou algum sistema) é notificado.

### Regras de alerta vivem no Prometheus; o roteamento vive no Alertmanager

```yaml
# prometheus-rules.yaml (carregado pelo Prometheus)
groups:
  - name: task-api
    rules:
      - alert: TaskApiIndisponivel
        expr: |
          (up{job="kubernetes-pods", pod=~"task-api-.*"} == 0)
          or
          absent(up{job="kubernetes-pods", pod=~"task-api-.*"})
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "task-api fora do ar"
          description: "Nenhum pod saudavel da task-api ha mais de 1 minuto."

      - alert: TaskApiErro5xxAlto
        expr: |
          rate(task_api_requests_total{status=~"5.."}[5m])
          / rate(task_api_requests_total[5m]) > 0.05
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "Taxa de erro 5xx acima de 5%"
```

- **`for: 1m`**: a condição precisa ser verdadeira **continuamente** por 1 minuto antes do
  alerta disparar de vez (fica em estado `pending` até lá) — evita alerta por um pico de 2
  segundos que se resolve sozinho.
- **`up{...} == 0`**: `up` é uma métrica que o **próprio Prometheus** gera pra cada target — 1
  se o último scrape teve sucesso, 0 se falhou. É a base de praticamente todo alerta de "está
  fora do ar".
- **`or absent(...)`** — a pegadinha real que vale entender: `up{...} == 0` só cobre o caso em
  que o target **ainda existe** na descoberta de serviço, mas o scrape falha (container travado,
  rede quebrada). Se o Pod for removido **inteiramente** (`kubectl scale --replicas=0`, por
  exemplo — foi exatamente o que aconteceu testando esta aula), o target some da lista de
  descoberta, e a série `up{...}` deixa de existir — não vira 0, simplesmente não há mais nada
  pra comparar com 0. `absent(...)` é a função feita pra esse segundo caso: ela retorna `1`
  exatamente quando a série **não existe**. Um alerta de disponibilidade robusto cobre os dois
  casos, combinados com `or`.
- **Razão (taxa de erro / taxa total)**, não erro absoluto: 5 erros em 10 requisições é grave;
  5 erros em 10 mil não é — a proporção conta a história certa, um número absoluto não.

### Do alerta disparado até a notificação

O Alertmanager recebe os alertas que o Prometheus dispara, agrupa (evita mandar 50 notificações
pra 50 Pods com o mesmo problema), silencia duplicados, e roteia pro destino certo
(e-mail, Slack, webhook...) — configuração fora do escopo hands-on desta aula, mas o
`amtool`/UI do Alertmanager permite ver alertas ativos mesmo sem nenhum canal de notificação
configurado, o que já é suficiente pra validar que as regras funcionam.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
