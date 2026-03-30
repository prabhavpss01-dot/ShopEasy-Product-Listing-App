# ShopEasy - Python Flask E-commerce App

A product listing web app with a complete DevOps CI/CD pipeline.

## Tech Stack
Python (Flask) · Docker · Jenkins · AWS EC2 · Prometheus · Grafana · Bash

## Run Locally
pip install -r requirements.txt
python app.py
# Visit http://localhost:5000

## Run with Docker
docker build -t shopeasy .
docker run -p 5000:5000 shopeasy

## CI/CD Flow
1. Developer pushes to GitHub
2. Webhook triggers Jenkins pipeline
3. Jenkins installs deps, builds Docker image, pushes to Docker Hub
4. Jenkins SSHs into App EC2, pulls image, runs container
5. Prometheus + Grafana monitor the EC2 instance
6. Cron job backs up container logs daily
