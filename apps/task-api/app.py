import json
import os
import time

from flask import Flask, Response, jsonify, request
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST

app = Flask(__name__)

REQUEST_COUNT = Counter(
    "task_api_requests_total",
    "Total de requisicoes recebidas",
    ["method", "path", "status"],
)
REQUEST_LATENCY = Histogram(
    "task_api_request_duration_seconds",
    "Duracao das requisicoes, em segundos",
    ["method", "path"],
)


@app.before_request
def _inicia_cronometro():
    request._start_time = time.time()


@app.after_request
def _registra_metrica(response):
    # request.path preserva a rota como veio (ex: /tasks/123) -- usamos
    # request.url_rule pra agrupar por rota (/tasks/<int:task_id>), senao cada
    # ID de tarefa vira uma serie temporal diferente (explode a cardinalidade).
    path = str(request.url_rule) if request.url_rule else request.path
    duracao = time.time() - getattr(request, "_start_time", time.time())

    REQUEST_COUNT.labels(request.method, path, response.status_code).inc()
    REQUEST_LATENCY.labels(request.method, path).observe(duracao)
    return response


@app.get("/metrics")
def metrics():
    return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)


class MemoryStore:
    """Guarda tasks numa lista em memoria do processo. Perde tudo ao reiniciar
    o container -- e exatamente por isso que a Aula 03 (Docker Compose)
    introduz o RedisStore abaixo."""

    def __init__(self):
        self._tasks = []
        self._next_id = 1

    def reset(self):
        self._tasks = []
        self._next_id = 1

    def list(self):
        return list(self._tasks)

    def add(self, title):
        task = {"id": self._next_id, "title": title, "done": False}
        self._tasks.append(task)
        self._next_id += 1
        return task

    def get(self, task_id):
        return next((t for t in self._tasks if t["id"] == task_id), None)

    def update(self, task_id, **fields):
        task = self.get(task_id)
        if task is None:
            return None
        task.update(fields)
        return task


class RedisStore:
    """Guarda as tasks como um JSON unico na chave 'tasks' do Redis. Simples
    de proposito -- o objetivo da Aula 03 e mostrar dois servicos conversando
    via docker-compose, nao ensinar modelagem de dados no Redis."""

    def __init__(self, redis_url):
        import redis

        self._redis = redis.Redis.from_url(redis_url, decode_responses=True)

    def _load(self):
        raw = self._redis.get("tasks")
        return json.loads(raw) if raw else []

    def _save(self, tasks):
        self._redis.set("tasks", json.dumps(tasks))

    def reset(self):
        self._redis.delete("tasks")

    def list(self):
        return self._load()

    def add(self, title):
        tasks = self._load()
        next_id = max((t["id"] for t in tasks), default=0) + 1
        task = {"id": next_id, "title": title, "done": False}
        tasks.append(task)
        self._save(tasks)
        return task

    def get(self, task_id):
        return next((t for t in self._load() if t["id"] == task_id), None)

    def update(self, task_id, **fields):
        tasks = self._load()
        task = next((t for t in tasks if t["id"] == task_id), None)
        if task is None:
            return None
        task.update(fields)
        self._save(tasks)
        return task


redis_url = os.environ.get("REDIS_URL")
store = RedisStore(redis_url) if redis_url else MemoryStore()


@app.get("/health")
def health():
    return jsonify(status="ok"), 200


@app.get("/tasks")
def list_tasks():
    return jsonify(store.list()), 200


@app.post("/tasks")
def create_task():
    body = request.get_json(silent=True) or {}
    title = body.get("title")
    if not title:
        return jsonify(error="title e obrigatorio"), 400
    return jsonify(store.add(title)), 201


@app.get("/tasks/<int:task_id>")
def get_task(task_id):
    task = store.get(task_id)
    if task is None:
        return jsonify(error="task nao encontrada"), 404
    return jsonify(task), 200


@app.patch("/tasks/<int:task_id>")
def update_task(task_id):
    body = request.get_json(silent=True) or {}
    fields = {k: v for k, v in body.items() if k in ("title", "done")}
    task = store.update(task_id, **fields)
    if task is None:
        return jsonify(error="task nao encontrada"), 404
    return jsonify(task), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
