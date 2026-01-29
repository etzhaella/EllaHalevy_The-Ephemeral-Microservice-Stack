FROM python:3.11-slim

WORKDIR /app

# Install basic dependencies required to build psycopg2
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# FastAPI will listen via uvicorn on 0.0.0.0
ENV PORT=8000
EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
