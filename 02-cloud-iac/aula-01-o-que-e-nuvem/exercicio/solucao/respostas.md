# Respostas — O que é nuvem de verdade

| # | Cenário | Categoria | Justificativa |
|---|---|---|---|
| 1 | EC2 + Postgres instalado manualmente | IaaS | Você recebe só a VM; SO, runtime e o banco em si são geridos por você. |
| 2 | RDS (Postgres gerenciado) | PaaS | Você cria o banco e usa — patch, backup e failover são da AWS. |
| 3 | Notion pra documentação | SaaS | Produto pronto, ninguém da empresa gerencia infraestrutura ou runtime dele. |
| 4 | Função no Lambda | PaaS (mais especificamente FaaS, um subtipo de PaaS) | Você só manda o código; servidor, runtime e scaling são da AWS. |
| 5 | Auto Scaling Group de EC2 configurado manualmente | IaaS | Mesmo com scaling automático, você ainda define AMI, SO e configuração — a "máquina" continua sendo sua responsabilidade. |
| 6 | Bucket S3 público por engano | Responsabilidade de quem configurou (não é da AWS) | Segurança **na** nuvem — permissões e configuração do recurso — é sempre de quem opera, não do provedor. |
| 7 | Vulnerabilidade no hypervisor | Responsabilidade da AWS | Segurança **da** nuvem — a camada física/virtualização — é integralmente da AWS; você nem tem acesso a essa camada. |
| 8 | Elastic Beanstalk com `.zip` | PaaS | Você manda só o artefato de código; deploy, SO e scaling ficam com a plataforma. |

## Por que isso importa pro resto do curso

Este curso foca em IaaS (EC2) e em orquestração por cima dele (Kubernetes) justamente porque é
aí que você precisa entender rede, SO, scaling e observabilidade na prática — em PaaS/SaaS
grande parte dessas decisões já vêm tomadas por você.
