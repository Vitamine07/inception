# 📘 User Documentation – Inception Project

This document provides clear and simple instructions on how to use, manage, and verify the Inception web infrastructure.

## 🏗 Services Overview

The infrastructure (or stack) is composed of three main services working together to provide a secure web environment:

| Service | Role | Details |
| --- | --- | --- |
| 🌐 NGINX | Secure Web Server | The entry point for all traffic. Handles encryption via TLS v1.2 / v1.3. |
| 📝 WordPress | CMS | The Content Management System. Runs using php-fpm. |
| 🗄 MariaDB | Database | Securely stores all website data (posts, users, settings). |

## 🛠 Managing the Project

You can control the entire infrastructure using simple make commands from the root of the project folder.

| Command | Action |
| --- | --- |
| make | Start: Builds Docker images and launches all services. |
| make stop | Stop: Stops running containers but keeps your data intact. |
| make down | Clean Up: Stops and removes containers and the network. |
| make re | Restart: Full rebuild and restart of the infrastructure. |

## 🌍 Accessing the Website

### ⚙️ Local Configuration

Before connecting for the first time, ensure your computer recognizes the site’s address. Add this line to your /etc/hosts file:

```
127.0.0.1 mbenzira.42.fr
```

### 🔗 Links

- Public Website: https://mbenzira.42.fr
- Administration Panel: https://mbenzira.42.fr/wp-admin

## 🔑 Credentials Management

For security reasons, no passwords or usernames are written directly in the project code.

- Location: All credentials are stored in the hidden file srcs/.env.

### Updating Credentials

1. Modify the values inside srcs/.env.
2. Restart the project to apply changes:

```
make re
```

## 🩺 Verifying Service Health

If the website is unreachable, check the status of the services using these methods:

### 🔍 Quick Status Check

Run the following command:

```
docker ps
```

The STATUS column should indicate Up for nginx, wordpress, and mariadb.

### 📜 Error Logs

If a service is behaving unexpectedly, check the real-time logs:

```
docker compose -f srcs/docker-compose.yml logs -f
```

## 🔒 SSL Security Note

> [!IMPORTANT]
> During the first connection, your browser will show a security warning: "Your connection is not private".
>
> This is normal because the project uses a self-signed SSL certificate.
>
> - Click Advanced
> - Click Proceed to mbenzira.42.fr