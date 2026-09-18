# Respostas — Primeiros passos no console

## Saída esperada de `cat /etc/os-release` (Amazon Linux 2023)

```
NAME="Amazon Linux"
VERSION="2023"
ID="amzn"
ID_LIKE="fedora"
VERSION_ID="2023"
PLATFORM_ID="platform:al2023"
PRETTY_NAME="Amazon Linux 2023"
```

## Por que restringir a origem do SSH

Um Security Group com porta 22 aberta pra `0.0.0.0/0` (qualquer IP da internet) transforma sua
instância em alvo de scanners automatizados — existem bots varrendo a internet inteira 24/7
procurando exatamente isso. Restringir a origem ao seu IP (`meu.ip.aqui/32`) reduz a superfície
de ataque de "toda a internet" pra "só eu".

Isso não substitui outras boas práticas (chave forte, `fail2ban`, desabilitar login por senha —
já vem desabilitado por padrão na AMI usada aqui), mas é a primeira e mais barata camada de
defesa, e é sobre isso que a Aula 07 (rede como código) volta a falar, desta vez via Terraform.

## Nota

Este exercício é manual por natureza — o "código" aqui é a sequência de decisões tomadas no
console. Guarde essa sequência de cabeça: é exatamente o que o `main.tf` da Aula 03 vai
reproduzir via código.
