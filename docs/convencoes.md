# Convenções do curso

## Commits

Use commits pequenos e descritivos. Sugestão de padrão:

`tipo: descrição curta`

Exemplos: `feat: adiciona dockerfile da aula 02`, `fix: corrige porta exposta no compose`.

## Branches

- `main`: sempre estável
- `aula-XX-descricao`: uma branch por exercício, quando fizer sentido praticar fluxo de PR

## Organização de exercícios

Cada exercício vive dentro da pasta da aula correspondente, em `exercicio/`:

```
aula-XX-nome/
├── README.md          # roteiro da aula
└── exercicio/
    └── enunciado.md   # o que fazer, passo a passo
```
