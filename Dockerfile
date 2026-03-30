FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

**3.2 Create `.dockerignore`**
```
__pycache__
*.pyc
*.pyo
.env
venv/