from flask import Flask, jsonify, request

app = Flask(__name__)

tasks = []
next_id = 1


@app.get("/health")
def health():
    return jsonify(status="ok"), 200


@app.get("/tasks")
def list_tasks():
    return jsonify(tasks), 200


@app.post("/tasks")
def create_task():
    global next_id
    body = request.get_json(silent=True) or {}
    title = body.get("title")
    if not title:
        return jsonify(error="title e obrigatorio"), 400

    task = {"id": next_id, "title": title, "done": False}
    tasks.append(task)
    next_id += 1
    return jsonify(task), 201


@app.get("/tasks/<int:task_id>")
def get_task(task_id):
    task = next((t for t in tasks if t["id"] == task_id), None)
    if task is None:
        return jsonify(error="task nao encontrada"), 404
    return jsonify(task), 200


@app.patch("/tasks/<int:task_id>")
def update_task(task_id):
    task = next((t for t in tasks if t["id"] == task_id), None)
    if task is None:
        return jsonify(error="task nao encontrada"), 404

    body = request.get_json(silent=True) or {}
    if "done" in body:
        task["done"] = bool(body["done"])
    if "title" in body:
        task["title"] = body["title"]
    return jsonify(task), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
