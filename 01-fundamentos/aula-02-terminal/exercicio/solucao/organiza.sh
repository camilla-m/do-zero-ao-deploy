#!/usr/bin/env bash
set -euo pipefail

pasta="${1:?uso: ./organiza.sh <pasta>}"
extensoes_movidas=""

for arquivo in "$pasta"/*; do
  [ -f "$arquivo" ] || continue

  nome="$(basename "$arquivo")"
  extensao="${nome##*.}"

  mkdir -p "$pasta/$extensao"
  mv "$arquivo" "$pasta/$extensao/"
  extensoes_movidas="$extensoes_movidas$extensao"$'\n'
done

echo "Resumo:"
echo -n "$extensoes_movidas" | sort | uniq -c | awk '{print "  " $2 ": " $1 " arquivo(s)"}'
