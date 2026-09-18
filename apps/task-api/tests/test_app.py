import pytest

from app import app, store


@pytest.fixture
def client():
    store.reset()
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_health(client):
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.get_json() == {"status": "ok"}


def test_lista_vazia(client):
    resp = client.get("/tasks")
    assert resp.status_code == 200
    assert resp.get_json() == []


def test_cria_task(client):
    resp = client.post("/tasks", json={"title": "aprender kubernetes"})
    assert resp.status_code == 201
    body = resp.get_json()
    assert body["title"] == "aprender kubernetes"
    assert body["done"] is False
    assert "id" in body


def test_cria_task_sem_title_falha(client):
    resp = client.post("/tasks", json={})
    assert resp.status_code == 400


def test_busca_task_inexistente(client):
    resp = client.get("/tasks/999")
    assert resp.status_code == 404


def test_atualiza_task(client):
    criada = client.post("/tasks", json={"title": "escrever testes"}).get_json()
    resp = client.patch(f"/tasks/{criada['id']}", json={"done": True})
    assert resp.status_code == 200
    assert resp.get_json()["done"] is True
