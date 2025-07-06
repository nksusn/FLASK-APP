
# Project 1: Docker Containerization Challenge
**Nebulance Systems BootCamp DevOps Class2025A**


## 📌 Project Summary

This project is about building and deploying a **Flask Visitor Counter Web Application**. Every time someone visits the webpage, a counter goes up by one and stores this data in a **MongoDB** database.

You are not just building the app — you are **containerizing it using Docker and Docker Compose** so it can run anywhere, anytime.

---

## ✅ Expected Outcome

- Web app running at: `http://localhost:5050`
- Big counter showing number of visitors
- Buttons to:
  - Refresh and count visits
  - View health and metrics
  - Reset counter
- Data stored in MongoDB and persists even after restarting
- Clear MongoDB connection status shown on the interface

---

## 📚 Key Terms Explained

- **Flask** – A Python tool used to build simple web apps.
- **Python** – A general-purpose, beginner-friendly programming language.
- **Visitor Counter** – Keeps track of how many people visit the page.
- **MongoDB** – A database that stores data in JSON-like format.
- **PyMongo** – Python tool that lets Flask communicate with MongoDB.
- **Bootstrap** – Makes the web interface responsive and modern.
- **Docker** – Packages your app and its environment in a “container.”
- **Dockerfile** – A script that tells Docker how to build the container.
- **Docker Compose** – Helps run multiple containers (Flask + MongoDB) together.
- **Volume** – Keeps MongoDB data safe even when containers stop.
- **Environment Variables** – Configurable app values in a `.env` file (like DB name, port).
- **Health Check** – Confirms the app and DB are working.
- **Graceful Degradation** – If MongoDB is down, the app still loads but shows a degraded status.










## 📁 Project Structure Overview

bootcamp-project-1/
├── app.py
├── Dockerfile
├── docker-compose.yml
├── .env
├── requirements.txt
└── templates/
└── index.html



## 🧾 .env File

Used to configure environment settings like port and database.

FLASK_ENV=development
DEBUG=True
PORT=5000
MONGODB_HOST=mongodb
MONGODB_PORT=27017
MONGODB_DB=visitor_counter

---

## 📦 Dockerfile

Used to build the container image for the Flask application.

FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000
ENV FLASK_ENV=production

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]

📂 docker-compose.yml
Used to run Flask and MongoDB together.
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5050:5000"
    environment:
      - FLASK_ENV=development
      - DEBUG=True
      - MONGODB_HOST=mongodb
      - MONGODB_PORT=27017
      - MONGODB_DB=visitor_counter
    depends_on:
      - mongodb
    volumes:
      - .:/app

  mongodb:
    image: mongo:latest
    container_name: mongodb
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

volumes:
  mongo_data:

📜 requirements.txt
Python dependencies.
Flask==2.3.3
pymongo==4.6.0
python-dotenv==1.0.0
gunicorn==21.2.0
Werkzeug==2.3.7

🧪 How the App Works (app.py Summary)
    • Starts a web server using Flask.
    • Connects to MongoDB using environment values.
    • Routes include:
        ◦ / — Displays the homepage and updates the visitor count
        ◦ /health — Returns JSON health status
        ◦ /metrics — Returns visit stats
        ◦ /reset — Resets the counter

🚀 Step-by-Step Deployment Guide
1. Open VS Code and Clone the Repo
git clone https://github.com/HILL-TOPCONSULTANCY/bootcamp-project-1.git
cd bootcamp-project-1

2. Check if Docker Is Installed
docker --version
You should see something like Docker version 24.0.0.

3. Install and start docker desktop on your local machine

4. Build and Run the Containers
docker-compose up --build -d
Explanation:
    • --build builds the image using Dockerfile
    • -d runs in the background

5. Access the Application
Open your browser and go to:
http://localhost:5050
You should see the web dashboard.

6. Test API Endpoints
curl http://localhost:5050/health
curl http://localhost:5050/metrics
curl -X POST http://localhost:5050/reset
Each returns a JSON response with status or data.

6. Test Data Persistence
docker-compose stop
docker-compose start -d


7. Simulate MongoDB Failure to test data persistence
Stop MongoDB:
docker stop mongodb
Now refresh the web page. MongoDB status will show as "Disconnected" and app status will be "Degraded".
To bring it back:
docker start mongodb
Refresh again to reconnect.
This stops the container and restarts it. Visitor count should still be there — thanks to volume storage. This confirms your data persistence.

8. Push to GitHub
git add .
git commit -m "Final flask project"
git push

✅ Success Criteria
    • Application loads at http://localhost:5050
    • Visitor counter increments with each visit
    • MongoDB stays connected and data is saved
    • /health, /metrics, /reset endpoints work
    • Restarting does not reset the counter

🧠 Learning Outcomes
You will learn to:
    • Containerize a Flask app with MongoDB
    • Use Docker and Docker Compose
    • Configure environments and dependencies
    • Set up persistent storage and service dependencies
    • Understand RESTful APIs and web app deployment

👨‍🏫 Final Notes
Take a screenshot of your app running and submit your GitHub repo.
Remember: MongoDB must persist data and all buttons should work.
You're done — congratulations on completing Project 1 of the Nebulance Systems BootCamp DevOps Class2025A!

