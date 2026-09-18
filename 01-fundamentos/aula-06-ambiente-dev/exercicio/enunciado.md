# Exercício — Ambiente de desenvolvimento produtivo

## Objetivo

Escrever um script que valida sozinho se o seu ambiente está pronto pro resto do curso, em vez
de descobrir na Aula 15 que o Terraform nunca foi instalado direito.

## Passo a passo

1. Escreva `check-ambiente.sh` que verifica, para cada ferramenta do checklist (Git, Docker,
   Terraform, AWS CLI, kubectl, kind **ou** minikube):
   - Se o comando existe (`command -v`).
   - Se existe, imprime a versão instalada.
   - Se não existe, marca como faltando — mas **continua checando as outras** (não para no
     primeiro erro).
2. Ao final, imprime um resumo: quantas ferramentas estão OK, quantas faltando, e sai com
   código de saída `1` se alguma estiver faltando (`0` se tudo OK) — isso importa porque no
   Módulo 4 você vai usar exit code pra decidir se um pipeline de CI passa ou falha.
3. Crie um `.editorconfig` na raiz deste diretório de exercício com: indentação de 2 espaços,
   fim de linha LF, charset UTF-8, remoção de espaço em branco no fim da linha.

## Critério de pronto

- `./check-ambiente.sh` roda até o fim mesmo se alguma ferramenta estiver faltando (não usa
  `set -e` de um jeito que mata o script no primeiro `command -v` que falha).
- O exit code reflete corretamente se tudo está OK ou não (`echo $?` depois de rodar).
- `.editorconfig` existe e tem as 4 regras acima.

## Entrega

Suba `check-ambiente.sh` e `.editorconfig` nesta pasta. Veja [`solucao/`](solucao/) para uma
referência.
