# O que é integração contínua na prática

**Módulo:** Módulo 4 — CI/CD
**Duração:** ~1h

## Roteiro

### O fluxo manual que todo mundo já viveu

```
escrever código → rodar testes na mão → esquecer de rodar um teste → build manual da imagem
→ subir pra algum lugar na mão → torcer → alguém acha um bug que "funcionava na minha máquina"
```

Cada seta nesse fluxo é um lugar onde um humano pode esquecer um passo, pular uma etapa sob
pressão de prazo, ou fazer diferente do combinado. **Integração Contínua (CI)** substitui essas
setas por automação: toda vez que código é enviado, uma máquina roda os mesmos passos, na mesma
ordem, sem cansaço e sem atalho.

### CI não é sobre ferramenta, é sobre hábito

O núcleo de CI é simples: **integrar código com frequência** (idealmente várias vezes ao dia,
não uma branch vivendo semanas isolada) e **validar automaticamente** cada integração — rodando
testes, lint, build. Quanto menor o intervalo entre "escrevi código" e "descobri que quebrou
algo", mais barato é consertar.

**Continuous Delivery (CD)** estende isso: depois que o código passa em CI, ele fica
automaticamente pronto pra ir pra produção (com um clique) ou vai **de verdade** (Continuous
*Deployment*) — é essa segunda forma que este módulo constrói, até o Kubernetes.

### O que uma pipeline de CI/CD tipicamente faz, em ordem

```
push/PR → checkout do código → instala dependências → roda lint/testes
        → builda a imagem Docker → publica a imagem → faz deploy → (opcional) testa em produção
```

Cada uma dessas etapas vira, no GitHub Actions (a ferramenta deste curso — já é onde o
repositório do curso vive), um **job** com uma sequência de **steps**. As próximas aulas
constroem essa pipeline inteira, uma etapa de cada vez, pra aplicação do curso.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
