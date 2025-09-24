# Dockerfile
FROM python:3.11-slim

# Устанавливаем системные зависимости, необходимые для сборки aiohttp и др.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libssl-dev \
    libffi-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Сначала копируем requirements и обновляем pip/wheel
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r /app/requirements.txt

# Копируем весь проект
COPY . /app

ENV PYTHONUNBUFFERED=1

CMD ["python", "telegram_teacher_bot.py"]
