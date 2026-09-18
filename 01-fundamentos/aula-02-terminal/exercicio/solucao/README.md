# Solução — Terminal e linha de comando essencial

## Parte 1 — `organiza.sh`

```bash
chmod +x organiza.sh
./organiza.sh ../dados/bagunca
```

Decisões:

- `set -euo pipefail` no topo: o script para no primeiro erro em vez de continuar silenciosamente
  (hábito que vale ouro quando você começar a escrever scripts que rodam dentro de pipelines de
  CI, no Módulo 4).
- `"${1:?uso: ...}"` valida que o argumento foi passado — se não foi, imprime a mensagem de uso
  e sai com erro, em vez de quebrar mais na frente com um erro confuso.
- `${nome##*.}` remove o maior prefixo possível até o último `.`, isolando a extensão.
- Em vez de array associativo (`declare -A`, que não existe no bash 3.2 do macOS), as extensões
  movidas são acumuladas numa string e agregadas no final com `sort | uniq -c` — o mesmo truque
  de "texto como estrutura de dados" da Parte 2.

## Parte 2 — `respostas.md`

Ver [`respostas.md`](respostas.md) — cada resposta vem com o comando usado. A ideia central
desta parte é combinar `grep`/`sort`/`uniq -c` para transformar texto bruto em uma contagem
agregada sem escrever nenhum código além de uma linha de pipe.
