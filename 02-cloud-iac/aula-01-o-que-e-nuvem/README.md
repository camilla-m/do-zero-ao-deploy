# O que é nuvem de verdade

**Módulo:** Módulo 2 — Cloud e Infraestrutura como Código
**Duração:** ~1h

## Roteiro

### "Tá na nuvem" não quer dizer nada sozinho

Nuvem é só computador de outra pessoa, alugado por hora/uso, acessível pela internet, com um
punhado de serviços prontos por cima. O que muda entre os provedores (AWS, GCP, Azure...) e
entre os produtos dentro de um provedor é **quanto da pilha você gerencia** versus **quanto o
provedor gerencia por você**.

### Os três modelos

```
                Você gerencia          Provedor gerencia
IaaS  (EC2)     SO, runtime, app       hardware, virtualização, rede física
PaaS  (Elastic  runtime, app           SO, patches, escalonamento
       Beanstalk)
SaaS  (Gmail)   nada                   tudo — você só usa
```

- **IaaS** (Infrastructure as a Service): você recebe uma máquina virtual crua. Ex.: EC2. Você
  decide SO, o que instalar, como configurar — máxima flexibilidade, máxima responsabilidade.
- **PaaS** (Platform as a Service): você manda o código, a plataforma cuida do resto (deploy,
  scaling, SO). Ex.: Elastic Beanstalk, Heroku. Menos controle, menos trabalho operacional.
- **SaaS** (Software as a Service): produto pronto, você só usa. Ex.: Gmail, Slack. Zero
  infraestrutura pra você pensar.

Este curso vive majoritariamente em **IaaS** (EC2, EKS) porque é onde as habilidades de DevOps
realmente aparecem — em PaaS/SaaS boa parte do trabalho já foi feito por outra pessoa.

### Regiões e zonas de disponibilidade

- **Região** (`us-east-1`, `sa-east-1`...): uma área geográfica com um conjunto de data
  centers. Escolha baseada em latência pros seus usuários e requisitos legais de onde o dado
  pode ficar.
- **Zona de disponibilidade** (AZ — `us-east-1a`, `us-east-1b`...): um ou mais data centers
  isolados dentro de uma região, com energia/rede independentes. Distribuir recursos entre AZs
  é a base da alta disponibilidade — se uma AZ cai, as outras seguem de pé.

### Responsabilidade compartilhada

A AWS é responsável pela segurança **da** nuvem (hardware, rede física, hypervisor). Você é
responsável pela segurança **na** nuvem (configuração de rede, IAM, patches do seu SO, dados).
Um bucket S3 público por engano é responsabilidade sua, não da AWS — ela só garante que o
serviço S3 em si funciona.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
