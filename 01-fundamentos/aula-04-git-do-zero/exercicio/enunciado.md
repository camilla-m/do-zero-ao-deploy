# Exercício — Git na prática: versionamento do zero

## Objetivo

Provocar um conflito de merge de propósito e resolvê-lo entendendo exatamente por que ele
aconteceu — não só "cliquei em aceitar as duas versões".

## Passo a passo

1. Crie o projeto:
   ```bash
   mkdir projeto-git && cd projeto-git
   git init -b main
   ```
2. Crie `cardapio.md`:
   ```markdown
   # Cardápio do Restaurante

   **Chef do dia:** a definir

   ## Pratos
   - Feijoada
   ```
   Commit: `git add cardapio.md && git commit -m "feat: cria cardapio inicial"`.

3. Crie a branch `adiciona-sobremesa` a partir da `main`. Nela:
   - Troque a linha `**Chef do dia:** a definir` para `**Chef do dia:** Ana`.
   - Adicione no final:
     ```markdown
     ## Sobremesas
     - Pudim
     ```
   - Commit: `feat: adiciona sobremesa e define chef`.

4. Volte pra `main` (**sem** dar merge ainda) e crie a branch `adiciona-bebida`, também a
   partir da `main` original. Nela:
   - Troque a **mesma** linha `**Chef do dia:** a definir` para `**Chef do dia:** Bruno`.
   - Adicione no final:
     ```markdown
     ## Bebidas
     - Suco de laranja
     ```
   - Commit: `feat: adiciona bebida e define chef`.

5. Volte pra `main` e dê merge na `adiciona-sobremesa` primeiro:
   ```bash
   git checkout main
   git merge adiciona-sobremesa
   ```
   Esse merge deve ser limpo (sem conflito).

6. Agora dê merge na `adiciona-bebida`:
   ```bash
   git merge adiciona-bebida
   ```
   Isso **vai** gerar conflito na linha `Chef do dia` (as duas branches mudaram a mesma linha
   de jeitos diferentes). Repare que provavelmente vai aparecer **um segundo conflito** também,
   nas seções `Sobremesas`/`Bebidas` — mesmo sendo conteúdo "diferente", as duas branches
   inseriram texto novo exatamente no mesmo ponto do arquivo (o final), e o Git não sabe qual
   das duas inserções deveria vir primeiro. Isso é normal: conflito de merge é sobre
   **posição no arquivo**, não sobre se o conteúdo é "relacionado" ou não.

7. Abra `cardapio.md`, resolva os dois conflitos (decida o que fazer com a linha do chef — ver
   critérios abaixo — e mantenha as duas seções novas), remova os marcadores (`<<<<<<<`,
   `=======`, `>>>>>>>`), e finalize:
   ```bash
   git add cardapio.md
   git commit
   ```

## Critério de pronto

- `git log --oneline --graph` mostra as duas branches convergindo na `main`.
- `cardapio.md` final tem as seções `Sobremesas` e `Bebidas`, e a linha do chef não tem
  marcador de conflito sobrando.
- Você documentou em `respostas.md`: por que o conflito aconteceu (nas suas palavras) e qual
  decisão você tomou pra resolver a linha do chef.

## Entrega

Suba o `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para uma referência — inclui um
script que reproduz o cenário do zero, caso você queira comparar o resultado.
