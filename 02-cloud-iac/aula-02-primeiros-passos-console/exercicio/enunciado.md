# Exercício — Primeiros passos no provedor de nuvem

## Objetivo

Subir manualmente uma VM pelo console EC2 e acessar via SSH — sem Terraform ainda, de
propósito, pra sentir o processo manual antes de automatizá-lo na Aula 03.

## Passo a passo

1. No console EC2, clique em **Launch Instance**.
2. Nome: `minha-primeira-vm`.
3. AMI: **Amazon Linux 2023** (free tier eligible).
4. Tipo de instância: `t2.micro` ou `t3.micro` (free tier).
5. Par de chaves: crie um novo (`.pem`), baixe e guarde — sem ele você não acessa a instância
   depois. No Linux/macOS: `chmod 400 minha-chave.pem` (a AWS recusa a conexão se a chave
   estiver com permissão aberta demais).
6. Configurações de rede: crie um Security Group novo permitindo **SSH (porta 22)** apenas do
   seu IP (não `0.0.0.0/0` — deixar SSH aberto pro mundo é o erro de iniciante mais comum e
   mais explorado).
7. Storage: padrão (8GB, free tier).
8. Launch instance.
9. Espere o status check ficar "2/2 checks passed", copie o IP público, e conecte:
   ```bash
   ssh -i minha-chave.pem ec2-user@<IP-PUBLICO>
   ```
10. Dentro da VM, rode `cat /etc/os-release` pra confirmar que você está mesmo lá dentro.
11. **Termine a instância** depois de terminar o exercício (Actions → Terminate instance) — não
    deixe rodando sem necessidade.

## Critério de pronto

- Você conseguiu conectar via SSH e rodar um comando dentro da VM.
- O Security Group restringe SSH ao seu IP, não a `0.0.0.0/0`.
- A instância foi terminada ao final.

## Entrega

Suba um `respostas.md` nesta pasta, com: a saída do `cat /etc/os-release`, e uma explicação de
por que restringir a origem do SSH importa (ver [`solucao/`](solucao/) pra referência).
