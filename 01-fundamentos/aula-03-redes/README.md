# Redes para quem nunca viu rede na vida

**Módulo:** Módulo 1 — Fundamentos
**Duração:** ~1h

## Roteiro

### O vocabulário mínimo

- **IP**: o endereço de uma máquina na rede (`203.0.113.10`, ou `::1` em IPv6). Sem ele,
  ninguém te acha.
- **Porta**: um número (0–65535) que identifica *qual serviço*, dentro da máquina, deve
  receber a conexão. `80` = HTTP, `443` = HTTPS, `22` = SSH, `5432` = Postgres. Uma máquina, um
  IP, várias portas — cada uma um serviço diferente escutando.
- **DNS**: a agenda de contatos da internet. Traduz nomes (`github.com`) em IPs, porque
  decorar IP é inviável.
- **TCP**: o protocolo que garante que os pacotes cheguem, na ordem certa, sem perder dado.
  Toda conexão HTTP começa com um *handshake* TCP (SYN → SYN-ACK → ACK) antes de trocar
  qualquer dado de verdade.
- **HTTP/HTTPS**: o protocolo de aplicação por cima do TCP. HTTPS é HTTP com uma camada TLS
  (criptografia) no meio — outro handshake, desta vez pra negociar chaves.

### As ferramentas que você vai usar pro resto da vida

```bash
ping github.com              # a máquina responde? (não passa por porta/HTTP, só ICMP)
dig github.com                # pergunta ao DNS: qual o IP desse nome?
curl -v https://github.com    # mostra a requisição inteira: DNS, conexão TCP, handshake TLS, headers, resposta
curl -I https://github.com    # só os headers da resposta (rápido, sem baixar o corpo)
traceroute github.com         # mostra cada "salto" de rede até o destino
nc -zv host porta             # testa se uma porta específica está aberta
ss -tulpn                     # lista portas escutando localmente (substituiu o netstat)
```

`curl -v` é a ferramenta mais importante desta lista — quando alguém disser "a API não
responde", o primeiro comando que você roda é esse, porque ele te diz *em qual etapa* a coisa
quebrou: não resolveu DNS? Conexão recusada? TLS falhou? Respondeu, mas com erro HTTP?

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
