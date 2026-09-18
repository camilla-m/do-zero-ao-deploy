# Ingress

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### O problema com Service pra várias aplicações

`NodePort`/`LoadBalancer` funcionam, mas cada aplicação exposta assim consome uma porta ou um
balanceador de carga (com custo!) próprio. Com 10 aplicações, isso vira 10 portas pra lembrar
ou 10 balanceadores pra pagar. **Ingress** resolve isso na camada HTTP: um único ponto de
entrada, roteando por **domínio** e **caminho** pra Services diferentes, por dentro do cluster.

### Ingress é só a regra — o Ingress Controller é quem executa

Um recurso `Ingress` sozinho não faz nada — ele é lido e aplicado por um **Ingress Controller**
(nginx-ingress, Traefik...), que precisa estar instalado no cluster. Pense no Ingress como a
configuração declarativa, e no Controller como o processo (geralmente um proxy nginx por baixo
dos panos) que de fato recebe tráfego e roteia.

```
Internet/host
     │
Ingress Controller (nginx, escutando nas portas 80/443)
     │
     ├── Host: task-api.local, Path: /  → Service task-api:80
     └── Host: outra-app.local, Path: /  → Service outra-app:80
```

### No `kind`, o Ingress Controller precisa de configuração extra

Diferente de um cluster gerenciado na nuvem (onde o Ingress Controller já provisiona um
LoadBalancer automaticamente), no `kind` é preciso: (1) recriar o cluster com
`extraPortMappings` publicando as portas 80/443 do node pro host, e (2) instalar o
`ingress-nginx` manualmente. É mais setup do que os outros recursos deste módulo — mas o
resultado (rotear por domínio) é o mesmo conceito usado em qualquer cluster de produção.

```bash
# 1. cluster com portas mapeadas (precisa recriar, se o cluster já existe sem isso)
kind create cluster --name do-zero-ao-deploy --config kind-config.yaml

# 2. instala o ingress-nginx
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
```

### O manifest do Ingress

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: task-api
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: task-api.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: task-api
                port:
                  number: 80
```

`task-api.local` não existe em DNS nenhum — pra funcionar na sua máquina, é preciso mapear esse
nome pro IP local em `/etc/hosts` (passo no exercício).

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
