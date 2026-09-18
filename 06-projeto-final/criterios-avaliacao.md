# Critérios de avaliação — Projeto Final

- [ ] **Infraestrutura via Terraform** — nenhum recurso criado manualmente no console.
      `terraform plan` limpo, sem drift entre o que o código declara e o que existe.
- [ ] **Aplicação containerizada e rodando no cluster Kubernetes** — Dockerfile com boas
      práticas (usuário não-root, camadas eficientes — Módulo 3, Aulas 02 e 04), manifests ou
      Helm chart aplicando sem erro.
- [ ] **Pipeline de CI/CD funcional** — commit → build → teste → deploy, sem passo manual no
      meio. Um teste quebrado precisa **de fato** impedir o deploy (prove isso, não só declare).
- [ ] **Observabilidade configurada** — métricas expostas pela aplicação, pelo menos 1
      dashboard com dado real (não um painel vazio), pelo menos 1 alerta **testado disparando
      de verdade** (não só a regra escrita).
- [ ] **README do projeto** explicando: o que a aplicação faz, arquitetura (diagrama ou
      descrição), decisões tomadas e por quê — principalmente qualquer ponto onde você se
      desviou do padrão usado no curso, e a razão.
- [ ] **Apresentação de até 10 minutos** mostrando o projeto rodando de ponta a ponta — não
      slides sobre o projeto, o projeto **funcionando**, ao vivo.

## O que não é exigido (pra calibrar expectativa)

- Alta disponibilidade real, múltiplas réplicas geograficamente distribuídas, DR — fora de
  escopo pra um projeto de curso.
- Cobertura de testes 100% — testes que provam que a pipeline barra quebra são mais importantes
  aqui do que cobertura extensa.
- Uma aplicação complexa — o Módulo 6 avalia a **pipeline**, não a sofisticação do produto.

## Como isso é avaliado

Cada item da checklist acima é binário: feito, ou não feito — não há nota parcial por "quase
funcionando". Um projeto pequeno com todos os 6 itens genuinamente funcionando (e demonstrados
ao vivo na apresentação) vale mais do que um projeto ambicioso com metade dos itens pela metade.
