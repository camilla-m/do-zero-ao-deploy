# Git colaborativo

**Módulo:** Módulo 1 — Fundamentos
**Duração:** ~1h

## Roteiro

### Clone vs. fork

- **Clone**: você tem acesso de escrita direto no repositório (é seu, ou é de um time do qual
  você faz parte). `git clone` traz uma cópia local com o histórico inteiro.
- **Fork**: você **não** tem acesso de escrita ao repositório original (ex: um projeto
  open-source de terceiros). O GitHub cria uma cópia do repositório na sua conta — você
  trabalha nesse fork e manda um Pull Request pedindo pro projeto original puxar suas mudanças.

Quando você faz fork, geralmente configura dois remotes:
```bash
git remote add origin git@github.com:seu-usuario/projeto.git      # seu fork
git remote add upstream git@github.com:dono-original/projeto.git  # original
git fetch upstream
git merge upstream/main   # traz atualizações do original pro seu fork
```

### O fluxo de Pull Request

1. Cria uma branch a partir da `main` atualizada: `git checkout -b minha-feature`.
2. Commita em cima dela, com mensagens pequenas e descritivas.
3. `git push origin minha-feature`.
4. Abre um PR no GitHub: branch origem → branch destino (geralmente `main`).
5. Alguém revisa — comenta, pede mudanças ou aprova.
6. Depois de aprovado, faz merge do PR (squash, merge commit ou rebase, dependendo da
   convenção do time).

O PR não é só "juntar código" — é o ponto onde outra pessoa lê sua mudança antes dela virar
parte permanente do projeto. Mensagens de commit e descrição de PR claras existem pra essa
pessoa, não pra você.

### Merge vs. rebase

Duas formas de trazer mudanças de uma branch pra outra:

- **`git merge`**: cria um commit novo que junta os dois históricos. Preserva exatamente o que
  aconteceu (inclusive os desvios), mas o histórico fica com "nós".
- **`git rebase`**: reescreve seus commits como se você tivesse começado a trabalhar a partir
  do estado mais recente da outra branch. Histórico fica linear, mas **reescreve commits** — só
  faça rebase em branches que ainda não foram compartilhadas/empurradas pra outras pessoas.

Regra prática: rebase a sua branch de feature antes de abrir o PR (deixa o histórico limpo);
não faça rebase de uma branch que outras pessoas já estão usando.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
