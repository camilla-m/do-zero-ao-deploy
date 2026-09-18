# Solução — Pipeline como código

`.github/workflows/reusable-test.yml` (novo) e `.github/workflows/ci.yml` (job `test` agora só
com uma chamada `uses:`) ficam na raiz do repositório. Ver [`respostas.md`](respostas.md) para
a confirmação de que o pipeline completo continuou passando depois da extração.
