# Solução — Git do zero

Rode [`setup.sh`](setup.sh) pra reproduzir o cenário do zero — ele cria o repositório
`projeto-git/`, faz os commits e branches do enunciado, e para bem no meio do merge
conflitante (a resolução em si é manual, de propósito).

```bash
./setup.sh
cd projeto-git
# resolva o conflito em cardapio.md, depois:
git add cardapio.md
git commit
```

Ver [`respostas.md`](respostas.md) pra explicação de por que apareceram **dois** conflitos (não
um) e qual decisão foi tomada em cada um.
