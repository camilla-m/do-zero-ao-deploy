# Respostas — Git colaborativo

## Por que o `git rebase` conflitou

Minha branch `eu/adiciona-contato` e a branch `colega/adiciona-membro` partiram do **mesmo
commit** (`feat: cria arquivo de equipe`). As duas mexeram no `equipe.md`:

- A do colega inseriu uma linha logo depois de `- Camilla (mantenedora)`.
- A minha inseriu um bloco novo no final do arquivo.

Quando fiz `git rebase origin/main`, o Git tentou "reaplicar" meu commit (`feat: adiciona secao
de contato`) em cima de um ponto de partida diferente do que ele tinha originalmente — a `main`
já continha a mudança do colega. Meu commit foi gerado como um diff contra o arquivo *sem* a
linha do Bruno; ao tentar aplicar esse diff contra o arquivo *com* a linha do Bruno, o contexto
não bateu exatamente e o Git não conseguiu aplicar automaticamente.

## Diferença entre resolver conflito de rebase e de merge

| | Merge | Rebase |
|---|---|---|
| O que está acontecendo | Cria **um commit novo** que junta os dois históricos | Reescreve **seus commits**, um por um, como se você tivesse partido do novo ponto |
| Como finalizar após resolver | `git add <arquivo>` + `git commit` (fecha o merge commit) | `git add <arquivo>` + `git rebase --continue` (continua reaplicando os commits restantes) |
| Se tiver mais de um commit na branch | Um conflito só, resolvido de uma vez | Pode conflitar **de novo a cada commit** reaplicado — `--continue` várias vezes |
| Histórico resultante | Tem um commit de merge (`Merge branch...`) | Linear, sem commit de merge — parece que você nunca saiu da ponta da `main` |
| Se der errado | `git merge --abort` | `git rebase --abort` |

Na prática: como o rebase reescreve o hash dos commits da branch, depois de resolver foi
necessário `git push --force` (ou `--force-with-lease`) pra atualizar a branch remota — um
push normal seria rejeitado, porque o histórico local e o remoto divergiram de verdade.

## Resultado

Depois do rebase resolvido, o merge final de `eu/adiciona-contato` na `main` foi **fast-forward**
(sem criar commit de merge), porque o rebase já tinha deixado minha branch como uma continuação
linear da `main`:

```
* feat: adiciona secao de contato
* feat: adiciona Bruno ao time
* feat: cria arquivo de equipe
```

`equipe.md` final:
```markdown
# Time de Plataforma

## Membros
- Camilla (mantenedora)
- Bruno (colaborador)

## Contato
- Slack: #time-plataforma
```
