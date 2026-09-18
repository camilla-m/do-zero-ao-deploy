# Respostas — Git do zero

## Por que o conflito aconteceu

Duas coisas, na verdade — e é importante ver que são motivos diferentes:

1. **A linha do chef** conflitou porque as duas branches partiram do mesmo commit (`feat: cria
   cardapio inicial`) e editaram **a mesma linha** pra valores diferentes (`Ana` vs `Bruno`).
   Quando a `main` já tinha absorvido a versão da `adiciona-sobremesa` (Ana), o merge da
   `adiciona-bebida` chegou com uma versão incompatível da mesma linha — o Git não tem como
   adivinhar qual prevalece.

2. **As seções `Sobremesas`/`Bebidas`** também conflitaram, e isso é menos óbvio: o conteúdo
   não é o mesmo, mas as duas branches inseriram texto novo **na mesma posição** do arquivo (logo
   depois de `- Feijoada`). Merge de três vias (*three-way merge*) compara linha a linha contra o
   ancestral comum — quando os dois lados inserem algo no mesmo lugar, o Git não sabe se a ordem
   correta é sobremesa-depois-bebida ou o contrário, então marca como conflito em vez de
   escolher por você.

## Decisão de resolução

- **Chef do dia:** em vez de escolher Ana *ou* Bruno, decidi manter os dois — `"Ana e Bruno
  (revezam por semana)"`. Nenhuma branch estava "mais certa"; a resolução não precisa ser
  "escolher um lado", pode ser uma terceira versão que preserva a intenção das duas.
- **Sobremesas/Bebidas:** mantive as duas seções, uma depois da outra — aqui não havia conflito
  de intenção real, só de posição no arquivo.

## Resultado

```
*   merge: resolve conflito de chef do dia e une sobremesa+bebida
|\
| * feat: adiciona bebida e define chef
* | feat: adiciona sobremesa e define chef
|/
* feat: cria cardapio inicial
```

`cardapio.md` final:

```markdown
# Cardápio do Restaurante

**Chef do dia:** Ana e Bruno (revezam por semana)

## Pratos
- Feijoada

## Sobremesas
- Pudim

## Bebidas
- Suco de laranja
```
