# Flask + Redis Multi-Container App

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

A multi-container application built with Flask and Redis, managed with Docker Compose. This was part of a hands-on Docker challenge to understand containerization, networking between containers, persistent storage, and environment variable management.

---

## What It Does

- `/` — returns a welcome message
- `/count` — increments and displays a visit counter stored in Redis

Every time you hit `/count` the count goes up. Restart the containers — count is still there. That's the persistent volume doing its job.

---


## Project Structure

```
multi-container-app/
    app.py                 # Flask application
    Dockerfile             # Multi-stage build
    docker-compose.yml     # Manages both containers
    requirements.txt       # Python dependencies
    .env                   # Environment variables (not committed)
    .env.example           # Template for environment variables
    .gitignore
```

---

## Services

| Service | Image | Port |
|---------|-------|------|
| Flask web app | custom build | 5000 |
| Redis database | redis:latest | internal only |

---

## How to Run

**1. Clone the repo:**
```bash
git clone https://github.com/rkarimkhanov/devops-learning.git
cd devops-learning/docker/multi-container-app
```

**2. Create your `.env` file:**
```bash
cp .env.example .env
```

**3. Start the containers:**
```bash
docker compose up -d
```

**4. Test it:**
```bash
# welcome message
curl http://localhost:5000

# visit counter
curl http://localhost:5000/count
```

---

## Key Concepts Applied

| Concept | How |
|---------|-----|
| Container networking | Flask talks to Redis by service name |
| Persistent volume | Redis data survives container restarts |
| Environment variables | Redis connection details read from `.env` |
| depends_on | Redis starts before Flask |

---

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `REDIS_HOST` | Redis service hostname | redis |
| `REDIS_PORT` | Redis service port | 6379 |

Copy `.env.example` to `.env` and fill in your values.

---

## Background

Part of my DevOps learning journey — transitioning from Linux system administration into DevOps. This project covers Docker fundamentals I'd previously only used at a surface level: compose networking, volumes, and proper secret management with environment variables.
