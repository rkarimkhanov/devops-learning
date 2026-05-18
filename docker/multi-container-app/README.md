# Flask + Redis Multi-Container App

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)


A multi-container application built with Flask and Redis, managed with Docker Compose. This was part of a hands-on Docker challenge to understand containerization, networking between containers, persistent storage, and environment variable management.


<img width="800" height="400" alt="architecture" src="https://github.com/user-attachments/assets/384e165a-e480-4dd0-8eda-7ee02d8b21df" /><svg width="800" height="400" xmlns="http://www.w3.org/2000/svg" font-family="monospace">

  <!-- Background -->
  <rect width="800" height="400" fill="#1a1a2e" rx="12"/>

  <!-- Title -->
  <text x="400" y="40" text-anchor="middle" fill="#ffffff" font-size="18" font-weight="bold">Multi-Container Application Architecture</text>

  <!-- Docker Compose Box -->
  <rect x="40" y="60" width="720" height="300" fill="none" stroke="#2496ED" stroke-width="2" stroke-dasharray="8,4" rx="10"/>
  <text x="60" y="85" fill="#2496ED" font-size="13" font-weight="bold">Docker Compose Network</text>

  <!-- User -->
  <rect x="60" y="110" width="120" height="70" fill="#2d2d44" stroke="#ffffff" stroke-width="1.5" rx="8"/>
  <text x="120" y="140" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="bold">User</text>
  <text x="120" y="158" text-anchor="middle" fill="#aaaaaa" font-size="11">Browser / curl</text>

  <!-- Arrow User to Flask -->
  <line x1="180" y1="145" x2="270" y2="145" stroke="#ffffff" stroke-width="1.5" marker-end="url(#arrow)"/>
  <text x="225" y="135" text-anchor="middle" fill="#aaaaaa" font-size="10">port 5000</text>

  <!-- Flask Container -->
  <rect x="270" y="95" width="180" height="110" fill="#2d2d44" stroke="#000000" stroke-width="1.5" rx="8"/>
  <rect x="270" y="95" width="180" height="30" fill="#000000" rx="8"/>
  <rect x="270" y="110" width="180" height="15" fill="#000000"/>
  <text x="360" y="116" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="bold">Flask Container</text>
  <text x="360" y="148" text-anchor="middle" fill="#aaaaaa" font-size="11">python:3.11-slim</text>
  <text x="360" y="166" text-anchor="middle" fill="#4CAF50" font-size="11">app.py</text>
  <text x="360" y="184" text-anchor="middle" fill="#aaaaaa" font-size="10">0.0.0.0:5000</text>

  <!-- Routes Box -->
  <rect x="270" y="220" width="180" height="70" fill="#1a1a2e" stroke="#444466" stroke-width="1" rx="6"/>
  <text x="360" y="240" text-anchor="middle" fill="#aaaaaa" font-size="11">Routes:</text>
  <text x="360" y="258" text-anchor="middle" fill="#4CAF50" font-size="11">/  →  Welcome</text>
  <text x="360" y="276" text-anchor="middle" fill="#4CAF50" font-size="11">/count  →  Visit Counter</text>

  <!-- Arrow Flask to Redis -->
  <line x1="450" y1="150" x2="540" y2="150" stroke="#DC382D" stroke-width="1.5" marker-end="url(#arrow-red)"/>
  <text x="495" y="140" text-anchor="middle" fill="#DC382D" font-size="10">port 6379</text>
  <text x="495" y="168" text-anchor="middle" fill="#aaaaaa" font-size="10">internal only</text>

  <!-- Redis Container -->
  <rect x="540" y="95" width="180" height="110" fill="#2d2d44" stroke="#DC382D" stroke-width="1.5" rx="8"/>
  <rect x="540" y="95" width="180" height="30" fill="#DC382D" rx="8"/>
  <rect x="540" y="110" width="180" height="15" fill="#DC382D"/>
  <text x="630" y="116" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="bold">Redis Container</text>
  <text x="630" y="148" text-anchor="middle" fill="#aaaaaa" font-size="11">redis:latest</text>
  <text x="630" y="166" text-anchor="middle" fill="#DC382D" font-size="11">key-value store</text>
  <text x="630" y="184" text-anchor="middle" fill="#aaaaaa" font-size="10">visits = 42</text>

  <!-- Volume Box -->
  <rect x="540" y="220" width="180" height="70" fill="#1a1a2e" stroke="#444466" stroke-width="1" rx="6"/>
  <text x="630" y="245" text-anchor="middle" fill="#aaaaaa" font-size="11">Persistent Volume</text>
  <text x="630" y="263" text-anchor="middle" fill="#FFC107" font-size="11">redis-data:/data</text>
  <text x="630" y="281" text-anchor="middle" fill="#aaaaaa" font-size="10">survives restarts</text>

  <!-- Arrow Redis to Volume -->
  <line x1="630" y1="205" x2="630" y2="220" stroke="#FFC107" stroke-width="1.5" marker-end="url(#arrow-yellow)"/>

  <!-- ENV Variables -->
  <rect x="270" y="310" width="180" height="40" fill="#1a1a2e" stroke="#444466" stroke-width="1" rx="6"/>
  <text x="360" y="328" text-anchor="middle" fill="#aaaaaa" font-size="10">REDIS_HOST=redis</text>
  <text x="360" y="344" text-anchor="middle" fill="#aaaaaa" font-size="10">REDIS_PORT=6379</text>

  <!-- Arrow markers -->
  <defs>
    <marker id="arrow" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#ffffff"/>
    </marker>
    <marker id="arrow-red" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#DC382D"/>
    </marker>
    <marker id="arrow-yellow" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#FFC107"/>
    </marker>
  </defs>

</svg>



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
