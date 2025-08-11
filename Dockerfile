# Stage 1: Build frontend
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/ .
RUN npm install && npm run build

# Stage 2: Backend + static files
FROM python:3.11-slim
WORKDIR /app
COPY app/ /app/
COPY --from=frontend-build /app/frontend/dist /app/static
RUN pip install --no-cache-dir -r requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
