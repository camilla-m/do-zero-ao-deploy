# Rede na nuvem via código

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### VPC: sua rede privada dentro da AWS

Uma **VPC** (Virtual Private Cloud) é uma rede isolada, só sua, dentro da AWS — você define o
range de IPs dela (`10.0.0.0/16`, por exemplo — 65 mil endereços) e, dentro desse range, cria
**subnets** menores.

### Subnet pública vs. privada — a diferença é a rota, não o nome

Nada na AWS marca uma subnet como "pública" ou "privada" de verdade — o que determina isso é
**pra onde a tabela de rotas dela aponta**:

- **Subnet pública**: a tabela de rotas tem uma rota `0.0.0.0/0 → Internet Gateway`. Qualquer
  recurso nela com IP público consegue ser alcançado da internet (e alcançar a internet).
- **Subnet privada**: sem rota direta pra um Internet Gateway. Recursos nela não são
  alcançáveis de fora — e, sem mais nada, também **não conseguem sair** pra internet.

```
Internet
   │
Internet Gateway (IGW)
   │
Route Table pública (0.0.0.0/0 → IGW)
   │
Subnet pública (10.0.1.0/24)  →  ex: load balancer, bastion host

Subnet privada (10.0.2.0/24)  →  ex: banco de dados, aplicação interna
   (sem rota pra IGW — isolada da internet de entrada e saída)
```

### NAT Gateway: dando saída (só saída) pra subnet privada

Se algo numa subnet privada precisa baixar um pacote ou chamar uma API externa (saída), sem
aceitar conexão de entrada, a peça é um **NAT Gateway** numa subnet pública, com uma rota na
tabela da subnet privada apontando pra ele.

**Atenção de custo**: ao contrário de quase tudo que você usou até agora, o NAT Gateway **cobra
por hora rodando**, mesmo parado, e não está no free tier — pode passar de US$ 30/mês. Por
isso, no exercício desta aula, ele fica atrás de uma variável desligada por padrão.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
