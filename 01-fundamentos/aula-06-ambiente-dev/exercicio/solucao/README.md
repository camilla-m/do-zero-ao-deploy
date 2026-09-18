# Solução — Ambiente de desenvolvimento produtivo

```bash
chmod +x check-ambiente.sh
./check-ambiente.sh
echo "exit code: $?"
```

Testado em macOS com tudo instalado (saída real):
```
Checando ambiente...
  [OK]      Git — git version 2.50.1 (Apple Git-155)
  [OK]      Docker — Docker version 29.4.3, build 055a478
  [OK]      Terraform — Terraform v1.15.6
  [OK]      AWS CLI — aws-cli/2.35.5 Python/3.14.6 Darwin/25.6.0 source/arm64
  [OK]      kubectl — Client Version: v1.36.3
  [OK]      kind — kind v0.33.0 go1.27.0 darwin/arm64

Resumo: 6 ok, 0 faltando.
exit code: 0
```

E com ferramentas faltando (`PATH` restrito de propósito, pra simular):
```
Resumo: 1 ok, 5 faltando.
exit code: 1
```

## Decisões

- `set -uo pipefail` sem o `-e`: o `-e` mataria o script no primeiro comando que retorna
  código diferente de zero — exatamente o que **não** queremos aqui, já que o objetivo é
  continuar checando mesmo quando uma ferramenta falta.
- Cada checagem usa `command -v` (não `which`) — é builtin do shell, mais portável, e não
  depende de `$PATH` estar configurado do jeito que `which` espera em todo sistema.
- Exit code reflete o resultado porque, a partir do Módulo 4, esse é exatamente o mecanismo que
  um pipeline de CI usa pra decidir "passou" ou "falhou" — treinar o hábito agora evita
  confusão depois.
