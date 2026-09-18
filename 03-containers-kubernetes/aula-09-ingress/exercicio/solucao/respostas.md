# Respostas — Ingress

```bash
kind delete cluster --name do-zero-ao-deploy
kind create cluster --name do-zero-ao-deploy --config kind-config.yaml
# kubectl config current-context mudou pra kind-do-zero-ao-deploy sozinho -- voltei pro
# context que eu estava usando antes, como o roteiro da Aula 05 recomenda

kubectl --context kind-do-zero-ao-deploy apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl --context kind-do-zero-ao-deploy wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=150s
# pod/ingress-nginx-controller-596f5b6bcf-mhpkk condition met

kubectl --context kind-do-zero-ao-deploy apply -f ingress.yaml
kubectl --context kind-do-zero-ao-deploy get ingress
```
```
NAME       CLASS   HOSTS            ADDRESS   PORTS   AGE
task-api   nginx   task-api.local             80      3s
```

```bash
$ curl --resolve task-api.local:8080:127.0.0.1 http://task-api.local:8080/health
{"status":"ok"}
```

Funcionou sem tocar em `/etc/hosts` — `--resolve` injeta a resolução DNS só pra essa
requisição do curl, sem afetar o resto do sistema.

## Ingress vs. Ingress Controller

O **`Ingress`** (`ingress.yaml`) é só uma declaração: "requisições pra `task-api.local/`
deveriam ir pro Service `task-api`". Sozinho, esse YAML não move um byte de tráfego — ele
precisa ser **lido e executado** por algo. Esse algo é o **`ingress-nginx-controller`**, um Pod
(na prática, um nginx configurado dinamicamente) que fica observando a API do Kubernetes por
objetos `Ingress`, e reconfigurando suas próprias rotas nginx toda vez que um `Ingress` é
criado, alterado ou removido.

É a mesma separação "declaração vs. execução" que aparece em todo o Kubernetes: o `Deployment`
declara "eu quero 2 réplicas", o Controller Manager executa; o `Ingress` declara "rotear assim",
o Ingress Controller executa.
