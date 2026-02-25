Voici ton fichier reformatté proprement en **Markdown (.md)**, prêt à être mis sur GitHub :

---

# 🛠 Developer Documentation – Inception Internal Project

This document details the technical architecture, workflow, and debugging procedures for the **Inception infrastructure**.

---

# 📦 Environment Configuration

## ✅ Prerequisites

To replicate this environment, the following tools must be installed on a Linux host (**Debian Bullseye recommended**):

* Docker Engine (v20.10+)
* Docker Compose (v2.0+)
* GNU Make

## 🌐 Local Domain Mapping

Add the following line to your `/etc/hosts` file:

```bash
127.0.0.1 mbenzira.42.fr
```

---

# 🔐 Secrets and Configuration

The project uses a central `.env` file located in the `srcs/` directory.

This file must define:

```env
DOMAIN_NAME=mbenzira.42.fr

SQL_DATABASE=
SQL_USER=
SQL_PASSWORD=
SQL_ROOT_PASSWORD=

WP_ADMIN_USER=
WP_ADMIN_PASSWORD=
WP_USER=
WP_USER_PASSWORD=
```

---

# 🚀 Workflow (Build & Launch)

The project is managed via a **Makefile** at the root of the repository.
This ensures consistency in commands for building and cleaning the environment.

## 📋 Available Commands

| Command       | Action Description                                                               |
| ------------- | -------------------------------------------------------------------------------- |
| `make`        | Builds Docker images and starts all services in the background                   |
| `make stop`   | Pauses running containers                                                        |
| `make down`   | Stops and removes containers and networks                                        |
| `make fclean` | **Evaluation Reset**: Stops everything and deletes images, networks, and volumes |
| `make re`     | Forces a full reconstruction of the entire infrastructure                        |

---

# 💾 Data Persistence (Bind Mounts)

Persistence is managed via **Bind Mounts**, linking host directories to container directories.
This allows data to survive container deletion.

## 📂 Host Paths

```
/home/mbenzira/data/mariadb
/home/mbenzira/data/wordpress
```

## 📂 Container Paths

| Service   | Container Path   |
| --------- | ---------------- |
| MariaDB   | `/var/lib/mysql` |
| WordPress | `/var/www/html`  |

### ❓ Why Bind Mounts?

They allow the administrator to manage files directly from the **mbenzira host system** without needing to explore Docker's internal storage.

---

# 🗄 Database Inspection (MariaDB)

During evaluation, you will need to prove the database is functional and contains the correct data.

## 🔹 Step 1: Access the MariaDB CLI

Run this command from your host terminal:

```bash
docker exec -it mariadb mysql -u root -p
```

Enter the **ROOT password** defined in your `.env` file when prompted.

---

## 🔹 Step 2: Essential SQL Queries for Debugging

Once inside the MariaDB prompt:

```sql
-- List all databases
SHOW DATABASES;

-- Access the specific WordPress database
USE wordpress_db;

-- List all tables (verify WordPress created its tables)
SHOW TABLES;

-- Verify WordPress users were created by the init script
SELECT user_login, user_email FROM wp_users;

-- Exit the database
exit
```

---

# 🐳 Docker Management and Debugging

## 📜 View All Logs in Real-Time

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

## 🔍 Check Service Status

```bash
docker ps
```

Ensure all containers are **Up**.

## 🌐 Inspect the Network

```bash
docker network inspect srcs_inception_network
```

Verify proper isolation.

---

# 🧾 WordPress Verification via CLI

```bash
docker exec -it wordpress wp user list --allow-root
```

This confirms that WordPress users were correctly initialized.

---

# 🏗 Technical Design Choices

## ⚙️ PID 1 Management

All services are launched via the `exec` command in their respective entrypoint scripts.
This ensures system signals (like `SIGTERM`) are handled correctly.

## 🚫 No Background Processes

As required by the 42 subject:

* No service runs in the background
* Everything runs in the foreground
* Containers remain active and responsive to logs

## 🔐 Network Security

* Containers share a dedicated bridge network
* The database is **not exposed on any host port**
* Internal service communication only

---

