# Exercício — Boas-vindas e o mapa do curso

## Objetivo

Configurar o mínimo de ambiente (Git + editor) e criar seu **diário de bordo**: um repositório
onde você vai registrar o que aprendeu em cada aula do curso. Ele vai te acompanhar até o
Módulo 6.

## Passo a passo

1. Instale o Git, se ainda não tiver:
   - macOS: `brew install git`
   - Ubuntu/WSL: `sudo apt install git`
2. Configure sua identidade (usada em todo commit que você fizer):
   ```bash
   git config --global user.name "Seu Nome"
   git config --global user.email "seu-email@exemplo.com"
   ```
3. Crie uma pasta local `diario-de-bordo` e inicialize um repositório Git nela.
4. Crie um `README.md` com:
   - Seu nome (ou apelido) e por que está fazendo o curso.
   - Uma seção `## Progresso` com uma lista de checkboxes, uma por módulo (`- [ ] Módulo 1 —
     Fundamentos`, etc).
5. Faça o primeiro commit.
6. Crie um repositório vazio no GitHub chamado `diario-de-bordo`, conecte como `origin` e dê
   push.

## Critério de pronto

- `git log` mostra pelo menos 1 commit.
- O repositório existe no seu GitHub e o README aparece lá.
- Você marcou o checkbox do Módulo 1 como feito depois de terminar esta aula.

## Entrega

Depois de publicar no GitHub, adicione o link do repositório dentro deste diretório em um
arquivo `LINK.md` (uma linha só, com a URL). Veja [`solucao/`](solucao/) para um exemplo
completo de como o README do diário pode ficar.
