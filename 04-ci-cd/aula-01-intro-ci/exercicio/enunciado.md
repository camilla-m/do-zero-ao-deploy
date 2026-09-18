# Exercício — O que é integração contínua na prática

## Objetivo

Mapear, em texto, o fluxo manual que você seguiria pra entregar uma mudança na `task-api` hoje
— sem nenhuma automação — e marcar onde CI/CD vai entrar nas próximas aulas.

## Passo a passo

1. Escreva, passo a passo, tudo que você faria manualmente pra levar uma mudança em
   `apps/task-api/app.py` até rodando no cluster Kubernetes local (Módulo 3), do jeito mais
   manual possível: editar código, rodar testes na mão, `docker build`, `kind load
   docker-image`, `kubectl apply`/`helm upgrade`...
2. Para cada passo, marque: **(a)** quanto tempo leva, **(b)** o que pode dar errado se alguém
   esquecer ou errar esse passo.
3. Marque quais desses passos as Aulas 02-05 deste módulo vão automatizar.

## Critério de pronto

- `respostas.md` com a lista de passos manuais, tempo estimado e risco de cada um.
- Pelo menos 3 passos identificados como "vai virar automação nas próximas aulas".

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para uma referência.
