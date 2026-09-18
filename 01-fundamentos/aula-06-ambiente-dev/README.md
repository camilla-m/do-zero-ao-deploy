# Ambiente de desenvolvimento produtivo

**Módulo:** Módulo 1 — Fundamentos
**Duração:** ~1h

## Roteiro

### O checklist completo pro resto do curso

A partir do Módulo 2 você vai precisar de tudo isso instalado e funcionando:

| Ferramenta | Pra quê | Checar com |
|---|---|---|
| Git | versionamento (já configurado na Aula 04) | `git --version` |
| Editor (VS Code recomendado) | escrever código e manifests | `code --version` |
| Docker | construir e rodar containers | `docker --version` && `docker info` |
| Terraform | infraestrutura como código (Módulo 2) | `terraform --version` |
| AWS CLI | interagir com a nuvem via terminal (Módulo 2) | `aws --version` |
| kubectl | falar com um cluster Kubernetes (Módulo 3) | `kubectl version --client` |
| kind ou minikube | cluster Kubernetes local, pra praticar sem custo de nuvem | `kind version` ou `minikube version` |

`docker info` (não só `docker --version`) importa porque a CLI pode estar instalada com o
daemon do Docker desligado — coisa que trava muita gente sem entender por quê.

### Deixando o terminal produtivo

Duas coisas que valem o investimento de 10 minutos:

- **Aliases** pros comandos que você vai digitar 50x por dia (`~/.zshrc` ou `~/.bashrc`):
  ```bash
  alias k=kubectl
  alias tf=terraform
  alias gs="git status"
  ```
- **Prompt com contexto**: saber em qual branch Git e (mais pra frente) em qual namespace de
  Kubernetes você está, sem digitar comando nenhum, evita o clássico "apliquei em produção
  pensando que tava local".

### Consistência de editor entre máquinas/pessoas de um time

Um arquivo `.editorconfig` na raiz de um projeto garante que qualquer editor (VS Code, Vim,
JetBrains...) respeite indentação e fim de linha do jeito que o time combinou — sem depender de
configuração pessoal de cada um. Vale a pena todo projeto ter um.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
