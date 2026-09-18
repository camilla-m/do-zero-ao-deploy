# Exercício — O que é nuvem de verdade

## Objetivo

Classificar 8 cenários reais entre IaaS, PaaS e SaaS, e entre "responsabilidade da AWS" ou
"responsabilidade sua", justificando cada resposta em uma frase.

## Cenários

Crie um `respostas.md` com uma tabela respondendo, para cada cenário: **categoria** (IaaS,
PaaS ou SaaS) e **uma frase de justificativa**.

1. Você sobe uma instância EC2 e instala o Postgres manualmente nela.
2. Você usa o AWS RDS (Postgres gerenciado) — só cria o banco e usa.
3. Sua empresa usa o Notion pra documentação interna.
4. Você escreve uma função e sobe no AWS Lambda, sem se preocupar com servidor.
5. Você configura um Auto Scaling Group de instâncias EC2 manualmente.
6. Um bucket S3 ficou público sem querer e vazou dados — de quem é a responsabilidade: da AWS
   ou de quem configurou o bucket?
7. Uma vulnerabilidade foi encontrada no **hypervisor** que roda as instâncias EC2 — de quem é
   a responsabilidade de corrigir?
8. Você usa o Elastic Beanstalk: manda o `.zip` do seu código Java e ele cuida do resto.

## Critério de pronto

- As 8 linhas da tabela preenchidas, com categoria certa e justificativa que mostra
  entendimento (não só "porque sim").
- Os cenários 6 e 7 respondidos corretamente sob a ótica de responsabilidade compartilhada (não
  é sobre IaaS/PaaS/SaaS, é sobre "quem gerencia o quê").

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para conferir.
