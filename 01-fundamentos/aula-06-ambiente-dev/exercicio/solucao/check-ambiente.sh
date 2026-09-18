#!/usr/bin/env bash
# Não usa "set -e": o objetivo é checar TODAS as ferramentas mesmo se uma faltar.
set -uo pipefail

ok=0
faltando=0

checa() {
  local nome="$1"
  local comando="$2"
  local flag_versao="$3"

  if command -v "$comando" >/dev/null 2>&1; then
    local versao
    versao="$($comando $flag_versao 2>&1 | head -1)"
    echo "  [OK]      $nome — $versao"
    ok=$((ok + 1))
  else
    echo "  [FALTA]   $nome — comando '$comando' não encontrado"
    faltando=$((faltando + 1))
  fi
}

echo "Checando ambiente..."
checa "Git"        git        --version
checa "Docker"     docker     --version
checa "Terraform"  terraform  --version
checa "AWS CLI"     aws        --version

if command -v kubectl >/dev/null 2>&1; then
  checa "kubectl" kubectl "version --client"
else
  echo "  [FALTA]   kubectl — comando 'kubectl' não encontrado"
  faltando=$((faltando + 1))
fi

if command -v kind >/dev/null 2>&1; then
  checa "kind" kind version
elif command -v minikube >/dev/null 2>&1; then
  checa "minikube" minikube version
else
  echo "  [FALTA]   cluster local (kind ou minikube) — nenhum dos dois encontrado"
  faltando=$((faltando + 1))
fi

echo
echo "Resumo: $ok ok, $faltando faltando."

if [ "$faltando" -gt 0 ]; then
  exit 1
fi
exit 0
