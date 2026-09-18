# Exercício — Por que observabilidade importa

## Objetivo

Antes de instalar qualquer ferramenta, escrever exatamente o que você **não consegue**
responder hoje sobre a `task-api` rodando — é o vazio que o resto do módulo preenche.

## Passo a passo

Responda em `respostas.md`, hoje, sem instalar nada novo (use só o que já existe até o Módulo
4):

1. Se a taxa de erro da `task-api` subisse de repente, você ficaria sabendo? Como?
2. Se um usuário reclamasse "às 14h de ontem, tentei criar uma tarefa e deu erro", você
   conseguiria confirmar isso e descobrir a causa? O que estaria disponível, o que não estaria?
3. Se o Pod da `task-api` estivesse consumindo memória crescente ao longo de dias (memory
   leak), até estourar e reiniciar sozinho — você notaria antes de acontecer, ou só depois,
   pelos logs do restart?
4. Para cada uma das 3 perguntas acima, qual pilar (métricas, logs, traces) resolveria — e qual
   aula deste módulo vai instalar essa peça?

## Critério de pronto

- As 4 respostas escritas, com honestidade sobre o que hoje é "eu não saberia".

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para uma referência.
