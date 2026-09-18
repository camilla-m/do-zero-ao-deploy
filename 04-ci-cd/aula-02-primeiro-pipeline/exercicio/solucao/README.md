# Solução — Primeiro pipeline com GitHub Actions

Ver [`ci.yml`](ci.yml) — versão inicial do pipeline. Esse arquivo evolui nas próximas aulas; a
versão que efetivamente fica em `.github/workflows/ci.yml`, na raiz do repositório, já inclui
os incrementos da Aula 03 em diante (é assim que uma pipeline de verdade cresce: em cima do
mesmo arquivo, não um arquivo novo por aula).

```bash
git add .github/workflows/ci.yml
git commit -m "ci: primeiro workflow"
git push
```

Depois do push, a aba **Actions** do GitHub mostra a execução. Ver [`respostas.md`](respostas.md).
