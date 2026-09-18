#!/usr/bin/env bash
# Reproduz o cenário completo do exercício: repo central + 2 clones simulando colaboração,
# incluindo o conflito de rebase e a resolução. Ao final, ./pratica-colaborativa/eu está na
# main, com o merge do colega e o rebase resolvido.
set -euo pipefail

rm -rf pratica-colaborativa
mkdir pratica-colaborativa && cd pratica-colaborativa

git init --bare -q central.git
git clone -q central.git eu
git clone -q central.git colega

# --- "eu" cria a base ---
cd eu
cat > equipe.md <<'EOF'
# Time de Plataforma

## Membros
- Camilla (mantenedora)
EOF
git add equipe.md
git -c user.email=eu@exemplo.com -c user.name=eu commit -q -m "feat: cria arquivo de equipe"
git push -q origin main
cd ..

# --- "colega" adiciona um membro ---
cd colega
git pull -q origin main
git checkout -b colega/adiciona-membro -q
sed -i.bak '/- Camilla (mantenedora)/a\
- Bruno (colaborador)
' equipe.md && rm -f equipe.md.bak
git add equipe.md
git -c user.email=colega@exemplo.com -c user.name=colega commit -q -m "feat: adiciona Bruno ao time"
git push -q origin colega/adiciona-membro
cd ..

# --- "eu" cria sua branch em paralelo, sem saber do PR do colega ---
cd eu
git checkout -b eu/adiciona-contato -q
cat >> equipe.md <<'EOF'

## Contato
- Slack: #time-plataforma
EOF
git add equipe.md
git -c user.email=eu@exemplo.com -c user.name=eu commit -q -m "feat: adiciona secao de contato"

# --- simula o merge do PR do colega na main ---
git checkout main -q
git fetch -q origin
git merge -q origin/colega/adiciona-membro -m "merge: adiciona-membro"
git push -q origin main

# --- tenta atualizar a branch via rebase: aqui conflita, de propósito ---
git checkout eu/adiciona-contato -q
git fetch -q origin
set +e
git rebase origin/main
echo
echo ">>> Conflito esperado acima. Resolva equipe.md manualmente, depois rode:"
echo ">>>   git add equipe.md && git rebase --continue"
