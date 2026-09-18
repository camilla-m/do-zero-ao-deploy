# Helm

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### O problema que o Helm resolve

Até aqui, cada aula acrescentou um arquivo `.yaml` novo: Deployment, Service, ConfigMap,
Secret, Ingress. Pra rodar a `task-api` num ambiente novo (ex: separar "dev" de "prod"), você
seria obrigado a duplicar todos esses arquivos e editar valores um por um — nome, quantidade de
réplicas, tag da imagem. **Helm** empacota tudo isso num **chart**: um conjunto de templates
YAML + um arquivo de valores, reutilizável entre ambientes.

### A anatomia de um chart

```
task-api/
├── Chart.yaml           # metadados: nome, versão do chart
├── values.yaml            # valores padrão (réplicas, tag de imagem, etc.)
└── templates/
    ├── deployment.yaml      # os mesmos manifests de antes, agora com {{ .Values.X }}
    ├── service.yaml
    ├── configmap.yaml
    └── secret.yaml
```

Um manifest de template usa a sintaxe Go templates pra injetar valores:

```yaml
# templates/deployment.yaml
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    spec:
      containers:
        - name: task-api
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
```

```yaml
# values.yaml
replicaCount: 2
image:
  repository: task-api
  tag: v2
```

### Comandos essenciais

```bash
helm create task-api                 # gera um chart de exemplo, como ponto de partida
helm install minha-release ./task-api    # instala o chart no cluster
helm upgrade minha-release ./task-api     # aplica mudanças (troque valores em values.yaml, ou
                                            # passe -f outro-arquivo.yaml / --set chave=valor)
helm list                                   # releases instaladas
helm uninstall minha-release                 # remove tudo que o chart criou, de uma vez
helm template ./task-api                      # renderiza os YAMLs finais, sem instalar — ótimo
                                                # pra debugar o que o Helm vai realmente aplicar
```

`helm uninstall` é o motivo prático mais forte pra usar Helm num curso: `kubectl delete -f`
exige lembrar de listar todo arquivo aplicado; `helm uninstall` remove **tudo** que a release
criou, de uma vez, rastreado automaticamente.

### values.yaml por ambiente

```bash
helm install task-api-dev ./task-api -f values-dev.yaml
helm install task-api-prod ./task-api -f values-prod.yaml
```

Mesmo chart, valores diferentes (réplicas, limites de recurso, tag de imagem) — sem duplicar um
único template.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
