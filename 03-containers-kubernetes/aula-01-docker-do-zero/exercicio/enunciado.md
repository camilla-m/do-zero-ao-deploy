# Exercício — Docker do zero

## Objetivo

Rodar, inspecionar e comparar containers de imagens públicas — sem escrever Dockerfile ainda
(isso é a Aula 02).

## Passo a passo

1. Suba um Nginx: `docker run -d -p 8080:80 --name meu-nginx nginx:alpine`. Acesse
   `http://localhost:8080` e confirme que responde.
2. Entre no container e explore: `docker exec -it meu-nginx sh`. Rode `ps aux` lá dentro —
   quantos processos aparecem? (Spoiler: bem menos do que na sua máquina — é isso que
   "isolamento" quer dizer na prática.)
3. Compare tamanho de imagens:
   ```bash
   docker pull nginx:alpine
   docker pull nginx:latest
   docker images nginx
   ```
   Qual é menor, e por quê (dica: `alpine` é uma distro Linux minimalista)?
4. Rode dois containers da mesma imagem ao mesmo tempo, em portas diferentes:
   ```bash
   docker run -d -p 8081:80 --name nginx-2 nginx:alpine
   ```
   Confirme com `docker ps` que os dois rodam simultaneamente, isolados um do outro.
5. Pare e remova tudo: `docker stop meu-nginx nginx-2 && docker rm meu-nginx nginx-2`.

## Critério de pronto

- `respostas.md` com: quantos processos apareceram no `ps aux` de dentro do container, a
  diferença de tamanho entre `nginx:alpine` e `nginx:latest`, e uma frase sobre o que "isolado"
  significou na prática no passo 4.

## Entrega

Suba `respostas.md` nesta pasta. Veja [`solucao/`](solucao/) para referência.
