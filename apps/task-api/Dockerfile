FROM python:3.12-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --target=/app/deps -r requirements.txt

FROM python:3.12-slim

WORKDIR /app
COPY --from=builder /app/deps /usr/local/lib/python3.12/site-packages
COPY app.py .

RUN useradd --create-home --shell /usr/sbin/nologin appuser
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
