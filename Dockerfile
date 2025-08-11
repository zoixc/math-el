# Stage 1: Build frontend
FROM node:18 AS frontend-build

WORKDIR /app/frontend

# Копируем только package.json и package-lock.json (если есть)
COPY frontend/package*.json ./

RUN npm install

COPY frontend/ .

RUN npm run build


# Stage 2: Backend + фронтенд статика
FROM python:3.11-slim

WORKDIR /app

# Устанавливаем зависимости для backend
COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Копируем backend
COPY app/ .

# Копируем собранный frontend из предыдущего stage
COPY --from=frontend-build /app/frontend/dist ./app/static

# Пробрасываем порт
EXPOSE 8000

# Запускаем FastAPI через uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
