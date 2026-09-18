# Exercício — Git colaborativo

## Objetivo

Simular sozinho(a) um fluxo de PR completo — incluindo um conflito resolvido via **rebase**
(não merge, que já foi praticado na Aula 04). Como o exercício é individual, vamos simular o
GitHub com um repositório "central" local e dois clones, um representando você e outro um(a)
colega.

## Passo a passo

1. Monte o cenário:
   ```bash
   mkdir pratica-colaborativa && cd pratica-colaborativa
   git init --bare central.git          # faz o papel do repositório no GitHub
   git clone central.git eu
   git clone central.git colega
   ```

2. **Como "eu"**, crie a base do projeto:
   ```bash
   cd eu
   cat > equipe.md <<'EOF'
   # Time de Plataforma

   ## Membros
   - Camilla (mantenedora)
   EOF
   git add equipe.md
   git commit -m "feat: cria arquivo de equipe"
   git push origin main
   ```

3. **Como "colega"**, puxe a `main` e abra uma branch adicionando um membro:
   ```bash
   cd ../colega
   git pull origin main
   git checkout -b colega/adiciona-membro
   # edite equipe.md: adicione a linha "- Bruno (colaborador)" logo abaixo da linha da Camilla
   git add equipe.md
   git commit -m "feat: adiciona Bruno ao time"
   git push origin colega/adiciona-membro
   ```

4. **De volta como "eu"**, sem saber ainda do PR do colega, crie sua própria branch a partir da
   `main` que você já tinha localmente:
   ```bash
   cd ../eu
   git checkout -b eu/adiciona-contato
   # edite equipe.md: adicione no final do arquivo
   #   ## Contato
   #   - Slack: #time-plataforma
   git add equipe.md
   git commit -m "feat: adiciona secao de contato"
   ```

5. Agora, **simule o merge do PR do colega** (como se você fosse a mantenedora aprovando):
   ```bash
   git checkout main
   git fetch origin
   git merge origin/colega/adiciona-membro
   git push origin main
   ```
   Isso deve ser limpo.

6. Volte pra sua branch e tente atualizar com a `main` mais recente **usando rebase** (não
   merge):
   ```bash
   git checkout eu/adiciona-contato
   git fetch origin
   git rebase origin/main
   ```
   Isso vai conflitar — resolva o conflito em `equipe.md`, depois:
   ```bash
   git add equipe.md
   git rebase --continue
   ```

7. Finalize o "PR": suba a branch e faça o merge final na `main`:
   ```bash
   git push origin eu/adiciona-contato
   git checkout main
   git merge eu/adiciona-contato
   git push origin main
   ```

## Critério de pronto

- `git log --oneline --graph` na `main` mostra os commits das duas branches integrados.
- `equipe.md` final tem os dois membros e a seção de contato.
- `respostas.md` explica: por que o `git rebase` conflitou no passo 6, e a diferença entre
  resolver conflito de rebase (`git rebase --continue`) e de merge (`git commit`).

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para uma referência.
