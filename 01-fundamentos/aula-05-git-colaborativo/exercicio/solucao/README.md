# Solução — Git colaborativo

Rode [`setup.sh`](setup.sh) pra reproduzir o cenário inteiro — cria o repositório central
(bare), os dois clones (`eu`/`colega`), o merge do colega, e para exatamente no conflito de
rebase, com a resolução ficando manual de propósito.

```bash
./setup.sh
cd pratica-colaborativa/eu
# resolva o conflito em equipe.md, depois:
git add equipe.md
git rebase --continue
git push -f origin eu/adiciona-contato
git checkout main
git merge eu/adiciona-contato   # fast-forward
git push origin main
```

Ver [`respostas.md`](respostas.md) para a explicação de por que o rebase conflitou e a
diferença entre `git rebase --continue` e `git commit` na hora de fechar um conflito.
