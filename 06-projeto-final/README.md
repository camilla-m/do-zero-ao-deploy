# Módulo 6 — Projeto Final

Até aqui, cada módulo construiu uma peça isolada, sempre sobre a mesma aplicação de exemplo
(`task-api`). O Projeto Final inverte isso: você escolhe (ou mantém) uma aplicação e monta,
sozinho(a), a pipeline inteira — infraestrutura, containers, CI/CD e observabilidade — do zero
ao deploy, exatamente como o nome do curso promete.

Não existe pasta `exercicio/solucao/` aqui, de propósito: não há uma resposta certa. O
`apps/task-api/` + `k8s/` + `.github/workflows/ci.yml` + `02-cloud-iac/` deste próprio
repositório **são** um exemplo completo e funcional de ponta a ponta — construído e testado ao
longo dos Módulos 2 a 5 — que você pode consultar quando travar, mas seu projeto final não
precisa (e idealmente não deveria) ser uma cópia dele.

## Aulas

### 1. Planejamento do projeto

Escolha uma aplicação pequena — **pequena de verdade**. O erro mais comum nesta fase é escolher
algo ambicioso demais e passar o módulo inteiro só configurando infraestrutura, sem nunca ver
nada rodando. Critérios pra uma boa escolha:

- Você consegue descrever o que ela faz em uma frase.
- Ela expõe HTTP (pra caber nos Módulos 3-5 sem adaptação).
- Ela **não precisa** ser original — reescrever a `task-api` com uma feature a mais, ou pegar
  qualquer API CRUD simples que você já tenha de outro contexto, é uma escolha perfeitamente
  válida. O objetivo deste módulo é a **pipeline**, não a aplicação.

Desenhe a arquitetura num diagrama simples (pode ser um desenho, ASCII, ou uma ferramenta de
diagrama) antes de escrever qualquer código de infra — decidir "VPC com subnet pública/privada,
EC2 ou EKS, um Postgres gerenciado ou não" **antes** de começar evita retrabalho no Módulo 2.

### 2. Infraestrutura do projeto final

Tudo via Terraform — sem clicar em nada no console (esse é literalmente o primeiro critério de
avaliação). Reaproveite os padrões do Módulo 2: variáveis, outputs, backend remoto se fizer
sentido pro seu projeto. Não precisa reinventar — copiar a estrutura de
`02-cloud-iac/aula-07-rede-como-codigo/exercicio/solucao/` como ponto de partida e adaptar é
esperado, não é cola.

### 3. Containerização e Kubernetes

Dockerfile (multi-stage se fizer sentido pra sua stack), manifests ou Helm chart — reaproveite
os padrões do Módulo 3. Decida: Deployment simples, ou vale a pena empacotar como chart (se seu
projeto vai ter mais de um ambiente, por exemplo)?

### 4. Pipeline de CI/CD completo

O critério de avaliação é literal: **commit → build → teste → deploy**, sem intervenção manual
no meio. Use `.github/workflows/ci.yml` deste repositório como referência de estrutura (jobs
encadeados com `needs`, cluster `kind` efêmero pra smoke test) — mas construa o seu do zero,
entendendo cada linha, não copiando sem ler.

### 5. Observabilidade do projeto final

Mínimo: sua aplicação expõe métricas (Prometheus), você tem pelo menos 1 dashboard (Grafana)
com dado real, e pelo menos 1 alerta que você **testou disparando de verdade** — não só
escreveu a regra e confiou que funciona. A Aula 04 do Módulo 5 mostrou por que testar de
verdade importa: uma regra de alerta que nunca foi provocada pode ter um bug que só aparece
quando o incidente é real.

### 6. Apresentação e feedback

Até 10 minutos, mostrando o projeto **rodando** — não slides. Roteiro sugerido: (1) um
`git push` disparando a pipeline ao vivo, (2) a aplicação respondendo no cluster, (3) o
dashboard com o tráfego gerado durante a apresentação, (4) uma decisão de arquitetura que você
tomou e o porquê.

## Entrega

Use a pasta [`template/`](template/) como ponto de partida pro seu projeto. Critérios de
avaliação em [`criterios-avaliacao.md`](criterios-avaliacao.md).
