# Solução — Boas-vindas e o mapa do curso

Exemplo de como o diário de bordo pode começar. Veja [`diario-de-bordo-exemplo.md`](diario-de-bordo-exemplo.md)
— copie o conteúdo para o `README.md` do seu próprio repositório `diario-de-bordo`.

## Comandos usados

```bash
git config --global user.name "Camilla"
git config --global user.email "camidevops@gmail.com"

mkdir diario-de-bordo && cd diario-de-bordo
git init
# cria o README.md com o conteúdo de diario-de-bordo-exemplo.md
git add README.md
git commit -m "chore: primeiro commit do diario de bordo"

git remote add origin git@github.com:seu-usuario/diario-de-bordo.git
git branch -M main
git push -u origin main
```

## Por que um repositório separado, e não uma pasta dentro deste curso?

Porque esse é o primeiro hábito profissional que o curso quer instalar: cada coisa que você
mantém no tempo (um diário, um projeto, uma automação pessoal) vira um repositório com
histórico próprio — não uma pasta solta no Desktop.
