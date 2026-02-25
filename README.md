# 🐳 Inception - 42 Project

*This project has been created as part of the 42 curriculum by [mbenzira].*

---

## 📝 Description

**Inception** is a System Administration project designed to deepen knowledge of virtualization and infrastructure orchestration using **Docker**. 

The goal is to build a high-availability small-scale infrastructure composed of several interconnected services. To ensure a thorough understanding of system configuration, all services are built from **Debian Bullseye**, prohibiting the use of "ready-to-use" automated images.

### 🏗️ Infrastructure Overview
* **NGINX**: Configured exclusively for **TLS v1.2/v1.3** to secure traffic.
* **WordPress**: Served via **php-fpm**. Note: Nginx and WordPress reside in separate containers.
* **MariaDB**: The relational database management system.

[Image of Docker container architecture showing Nginx, WordPress, and MariaDB]

---

## 🛠️ Project Description & Design Choices

The architecture follows the **Principle of Least Privilege** and strict service isolation. Every component is sandboxed, communicating only via a dedicated private network.

### Design Choices
* **Custom Init Scripts**: We use specific entrypoint scripts to automate the creation of databases and WordPress users (via WP-CLI). These scripts ensure everything is ready *before* the main service starts.
* **PID 1 Management**: All services are launched using the `exec` command. This ensures that the service (e.g., MariaDB) becomes the primary process (PID 1), allowing Docker to handle signals (like stop/restart) correctly and gracefully.

### 📊 Technical Comparisons

| Feature | Virtual Machines vs Docker |
| :--- | :--- |
| **Virtual Machines** | Virtualize hardware. Each VM has a full OS, making them heavy and slow to boot. |
| **Docker** | Virtualizes the OS kernel. Containers share the host kernel, making them lightweight and extremely fast. |

| Feature | Secrets vs Env Variables |
| :--- | :--- |
| **Env Variables** | Simple to use but visible in process logs and `docker inspect`. |
| **Secrets** | More secure. Sensitive data (passwords) is provided to the container at runtime without being stored in the image. |

| Feature | Docker Network vs Host Network |
| :--- | :--- |
| **Host Network** | The container shares the host's IP and ports directly (low security/isolation). |
| **Docker Network** | Creates a private virtual bridge. Containers communicate via internal DNS (