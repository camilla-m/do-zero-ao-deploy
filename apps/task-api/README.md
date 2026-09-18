# task-api

A aplicação usada nos Módulos 3, 4, 5 e 6 do curso — uma API de tarefas bem simples, de
propósito, pra manter o foco nas ferramentas de DevOps (Docker, Kubernetes, CI/CD,
observabilidade) e não na complexidade da aplicação em si.

Este código é o ponto de partida. Ele evolui ao longo do curso: o Módulo 3 adiciona um
`Dockerfile`, o Módulo 5 adiciona instrumentação de métricas — cada aula documenta o que mudou
e por quê no `README.md` da sua própria pasta de solução.

## Rodando localmente

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
python app.py            # sobe em http://localhost:5000 (cuidado: no macOS a porta 5000
                          # pode colidir com o AirPlay Receiver — troque a porta se precisar)
```

## Endpoints

| Método | Rota | Descrição |
|---|---|---|
| GET | `/health` | Healthcheck — `{"status": "ok"}` |
| GET | `/tasks` | Lista todas as tarefas |
| POST | `/tasks` | Cria uma tarefa — body `{"title": "..."}` |
| GET | `/tasks/<id>` | Busca uma tarefa por ID |
| PATCH | `/tasks/<id>` | Atualiza `title` e/ou `done` |

## Testes

```bash
pytest
```

## Por que Flask, e por que em memória

Flask porque é o framework Python mais simples de ler pra quem nunca viu o código — sem
"mágica" de ORM ou injeção de dependência atrapalhando o que interessa neste curso. Armazenamento
em memória (uma lista Python) porque persistência de dados é assunto de outro curso — aqui, o
que importa é ter algo real pra containerizar, orquestrar, entregar via pipeline e monitorar.
