# app/

Coloque aqui o código da sua aplicação — o que ela é, tecnologia, tudo isso é escolha sua.

Requisitos mínimos pra caber no resto da pipeline (Módulos 3-5 deste curso):

- Expõe HTTP.
- Tem um endpoint de healthcheck (`/health` ou equivalente) — usado no smoke test do CI/CD
  (Módulo 4, Aula 05) e nas probes do Kubernetes.
- Tem um `Dockerfile` (Módulo 3, Aulas 02 e 04).
- Se for expor métricas Prometheus (Módulo 5, Aula 02), um endpoint `/metrics`.

Não existe restrição de linguagem/framework — o padrão usado no resto do curso (Python/Flask)
é só o exemplo do curso, não um requisito do seu projeto.
