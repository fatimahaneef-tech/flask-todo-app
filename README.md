# 📝 Flask Todo App

A containerized Todo List application built with **Flask**, featuring Docker support, CI/CD automation, and cloud deployment using Terraform on AWS.

![Python](https://img.shields.io/badge/Python-3.11-blue)
![Flask](https://img.shields.io/badge/Flask-3.0.3-black)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?logo=githubactions)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-FF9900?logo=amazonaws)

---

## 🚀 Features

- Add new tasks
- Mark tasks as completed
- Delete tasks
- Persistent JSON-based storage
- Docker containerization
- Automated CI/CD with GitHub Actions
- Infrastructure provisioning with Terraform
- Ready for deployment on AWS EC2

---

## 📦 Quick Start

### Run Locally

```bash
pip install -r requirements.txt
python app.py
```

Open your browser and visit:

```
http://127.0.0.1:5000
```

---

### Run with Docker

Build the Docker image:

```bash
docker build -t todo-app .
```

Run the container:

```bash
docker run -p 5000:5000 todo-app
```

Then open:

```
http://localhost:5000
```

---

### Deploy to AWS

```bash
terraform init
terraform apply
```

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|------------|
| Frontend | HTML, CSS |
| Backend | Python, Flask |
| Containerization | Docker |
| CI/CD | GitHub Actions |
| Infrastructure as Code | Terraform |
| Cloud | AWS EC2 |

---

## 📂 Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── static/
│   └── style.css
├── templates/
│   └── index.html
├── app.py
├── todos.json
├── requirements.txt
├── Dockerfile
├── main.tf
└── README.md
```

---

## 📄 License

This project is licensed under the MIT License.