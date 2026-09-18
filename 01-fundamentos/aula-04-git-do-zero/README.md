# Git na prática: versionamento do zero

**Módulo:** Módulo 1 — Fundamentos
**Duração:** ~1h

## Roteiro

### O modelo mental (isso importa mais que decorar comando)

Git não guarda "diferenças entre arquivos" — ele guarda **snapshots**. Cada commit é uma foto
completa do estado do seu projeto naquele momento, e o Git é esperto o suficiente pra só
armazenar o que mudou de fato entre um snapshot e outro.

Três áreas, sempre:

```
diretório de trabalho  --git add-->  staging area  --git commit-->  histórico (.git)
   (o que você edita)      (o que vai         (snapshots
                           no próximo             permanentes)
                            commit)
```

- `git add` não salva nada permanente — só marca "isso vai entrar no próximo commit".
- `git commit` é o que cria o snapshot de verdade, com uma mensagem explicando o porquê.
- `git status` a qualquer momento te diz em qual dessas três áreas cada arquivo está.

### Branches são só ponteiros

Uma branch **não é uma cópia do projeto**. É só um ponteiro (um arquivo de 41 bytes) apontando
pra um commit específico. `git branch nova-feature` custa literalmente nada — é por isso que no
Git, ao contrário de outros sistemas de versionamento mais antigos, criar branch é barato e
constante, não um evento raro.

```bash
git branch                  # lista branches locais
git branch feature-x        # cria (não muda pra ela)
git checkout feature-x      # muda pra ela
git checkout -b feature-x   # cria e já muda, em um comando
```

### Merge e conflito

`git merge outra-branch` tenta juntar o histórico de duas branches. Se as duas mexeram em
partes diferentes dos arquivos, o Git resolve sozinho (*merge automático*). Se as duas mexeram
**na mesma linha**, ele não adivinha — para e te entrega o arquivo com marcadores:

```
<<<<<<< HEAD
sua versão
=======
versão da outra branch
>>>>>>> outra-branch
```

Resolver um conflito é: abrir o arquivo, decidir o que deve ficar (uma versão, a outra, ou uma
mistura), apagar os marcadores (`<<<<<<<`, `=======`, `>>>>>>>`), e fazer `git add` +
`git commit` pra fechar o merge.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
