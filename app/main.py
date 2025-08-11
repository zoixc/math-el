from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from calculations import process_expression
import os

app = FastAPI()

# Статические файлы (React build)
static_dir = os.path.join(os.path.dirname(__file__), "static")
app.mount("/static", StaticFiles(directory=static_dir), name="static")

@app.post("/api/calculate")
async def calculate(request: Request):
    data = await request.json()
    expr = data.get("expression", "")
    result = process_expression(expr)
    return {"result": result}

@app.get("/{full_path:path}")
async def serve_frontend(full_path: str):
    index_path = os.path.join(static_dir, "index.html")
    if os.path.exists(index_path):
        return FileResponse(index_path)
    return {"error": "Frontend not built yet"}
