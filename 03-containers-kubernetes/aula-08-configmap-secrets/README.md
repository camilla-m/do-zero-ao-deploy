# ConfigMaps e Secrets

**Módulo:** Módulo 3 — Containers e Kubernetes
**Duração:** ~1h

## Roteiro

### Por que não colocar configuração direto no `deployment.yaml`

Você poderia escrever `env: - name: REDIS_URL value: "redis://..."` direto no Deployment. Mas
aí, pra mudar um valor de configuração, você precisa editar e reaplicar o manifest inteiro — e
qualquer segredo (senha, chave de API) fica em texto plano dentro de um arquivo que
provavelmente vai pro Git. **ConfigMap** e **Secret** separam configuração do manifest de
carga de trabalho.

### ConfigMap: configuração não-sensível

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: task-api-config
data:
  LOG_LEVEL: "info"
  APP_NAME: "task-api"
```

### Secret: mesma ideia, pra dado sensível

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: task-api-secret
type: Opaque
stringData:
  REDIS_URL: "redis://cache:6379/0"
```

`stringData` aceita texto puro (o Kubernetes codifica em base64 internamente ao salvar); o
campo `data` exigiria que você mesmo codificasse cada valor em base64 antes. **Atenção**: um
Secret padrão do Kubernetes é só **ofuscado** em base64, não criptografado — qualquer pessoa
com acesso de leitura ao cluster consegue decodificar. Em produção real, isso se combina com
criptografia do etcd em repouso e RBAC restrito; por ora, o que importa é o padrão de uso.

### Consumindo no Pod

```yaml
containers:
  - name: task-api
    envFrom:
      - configMapRef:
          name: task-api-config
      - secretRef:
          name: task-api-secret
```

`envFrom` injeta **todas** as chaves do ConfigMap/Secret como variáveis de ambiente de uma vez
— alternativa a listar uma por uma com `env: - name: X valueFrom: configMapKeyRef: ...`, que dá
mais controle mas é mais verboso.

## O que você vai praticar

Ver [`exercicio/enunciado.md`](exercicio/enunciado.md).
