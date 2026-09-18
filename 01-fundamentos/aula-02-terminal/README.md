# Terminal e linha de comando essencial

**Módulo:** Módulo 1 — Fundamentos
**Duração:** ~1h

## Roteiro

### Navegação e arquivos

```bash
pwd                 # onde eu estou
ls -la               # lista tudo, incluindo ocultos, em formato longo
cd caminho/          # entra numa pasta
cd ..                # sobe um nível
mkdir -p a/b/c        # cria pastas aninhadas de uma vez
cp origem destino     # copia
mv origem destino     # move ou renomeia
rm arquivo            # remove (rm -r pasta/ pra remover pasta inteira)
```

### Permissões

Todo arquivo no Linux tem dono, grupo e um conjunto de permissões (leitura/escrita/execução)
para cada um dos três: dono, grupo, outros.

```bash
ls -l arquivo.sh
# -rwxr-xr-- 1 camilla staff 120 ...
#  ^^^ ^^^ ^^^
#  dono grupo outros

chmod +x script.sh     # dá permissão de execução pro dono
chmod 644 arquivo.txt  # rw- r-- r-- (leitura/escrita dono, leitura resto)
chown usuario arquivo  # muda o dono
```

### Processos

```bash
ps aux              # lista processos rodando
top                  # monitor em tempo real (q pra sair)
comando &            # roda em background
jobs                 # lista jobs em background da sessão atual
kill <PID>           # termina um processo (kill -9 força)
```

### Busca e manipulação de texto — o combo que você vai usar todo santo dia

```bash
find . -name "*.log"              # acha arquivos por nome
grep "ERROR" arquivo.log          # filtra linhas que contém um padrão
grep -r "TODO" .                  # procura recursivamente em todas as pastas
grep -c "ERROR" arquivo.log       # conta quantas linhas batem
wc -l arquivo.log                 # conta linhas
sort arquivo.txt | uniq -c        # ordena e conta ocorrências únicas
cat a.log b.log | grep ERROR      # combina arquivos e filtra
```

O `|` (pipe) é o conceito mais importante desta aula: ele pega a saída de um comando e manda
como entrada pro próximo. Comandos pequenos, combinados, resolvem problemas grandes — essa é a
filosofia Unix, e é a mesma filosofia por trás de pipelines de CI/CD que você vai construir no
Módulo 4.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
