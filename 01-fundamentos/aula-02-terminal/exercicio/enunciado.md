# Exercício — Terminal e linha de comando essencial

## Parte 1 — Organizador de arquivos

Em [`dados/bagunca/`](dados/bagunca/) tem uma pasta com arquivos de tipos misturados (fotos,
documentos, scripts, planilhas...) — do jeito que qualquer pasta de Downloads vive.

Escreva um script `organiza.sh` que:

1. Recebe o caminho da pasta bagunçada como argumento (`./organiza.sh dados/bagunca`).
2. Para cada arquivo, cria uma subpasta com o nome da extensão (`jpg/`, `pdf/`, `csv/`...) se
   ela não existir, e move o arquivo pra lá.
3. Ao final, imprime um resumo: quantos arquivos foram movidos, por extensão.

Dica: `"${arquivo##*.}"` extrai a extensão de um nome de arquivo em bash.

## Parte 2 — Investigando logs

Em [`dados/app.log`](dados/app.log) tem um log de aplicação com linhas `INFO`, `WARN` e
`ERROR`. Usando só `grep`, `wc`, `sort`, `uniq` e pipes (sem escrever script, direto no
terminal), responda em um arquivo `respostas.md`:

1. Quantas linhas `ERROR` existem no total?
2. Quais são os 3 IPs que mais aparecem no log (considerando todas as linhas)?
3. Quantas linhas aconteceram entre `10:15` e `10:20`?

## Critério de pronto

- `./organiza.sh dados/bagunca` roda sem erro e separa os arquivos em subpastas por extensão.
- `respostas.md` tem as 3 respostas da Parte 2, cada uma com o comando usado para chegar nela.

## Entrega

Suba `organiza.sh` e `respostas.md` nesta pasta, com um `README.md` curto explicando as
decisões do script. Veja [`solucao/`](solucao/) para uma referência.
