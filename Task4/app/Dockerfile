FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /opt/app

COPY requirements.txt /opt/app/requirements.txt
RUN pip install --no-cache-dir -r /opt/app/requirements.txt

COPY app.py /opt/app/app.py

EXPOSE 8080

CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port ${APP_PORT:-8080}"]