#!/usr/bin/env bash
# Reproduz o cenário do exercício do zero, até o ponto exato do conflito.
# Depois de rodar, o repositório em ./projeto-git fica com o merge conflitante em aberto —
# a resolução é o passo manual, feito em seguida (ver README.md desta pasta).
set -euo pipefail

rm -rf projeto-git
mkdir projeto-git && cd projeto-git
git init -b main -q

cat > cardapio.md <<'EOF'
# Cardápio do Restaurante

**Chef do dia:** a definir

## Pratos
- Feijoada
EOF
git add cardapio.md
git commit -q -m "feat: cria cardapio inicial"

git checkout -b adiciona-sobremesa -q
sed -i.bak 's/\*\*Chef do dia:\*\* a definir/**Chef do dia:** Ana/' cardapio.md && rm cardapio.md.bak
cat >> cardapio.md <<'EOF'

## Sobremesas
- Pudim
EOF
git add cardapio.md
git commit -q -m "feat: adiciona sobremesa e define chef"

git checkout main -q
git checkout -b adiciona-bebida -q
sed -i.bak 's/\*\*Chef do dia:\*\* a definir/**Chef do dia:** Bruno/' cardapio.md && rm cardapio.md.bak
cat >> cardapio.md <<'EOF'

## Bebidas
- Suco de laranja
EOF
git add cardapio.md
git commit -q -m "feat: adiciona bebida e define chef"

git checkout main -q
git merge adiciona-sobremesa -q -m "merge: adiciona-sobremesa"

echo "Merge limpo da adiciona-sobremesa feito. Tentando merge da adiciona-bebida (vai conflitar)..."
set +e
git merge adiciona-bebida
set -e

echo
echo "=== cardapio.md com marcadores de conflito ==="
cat cardapio.md
