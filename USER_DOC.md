# 📘 User Documentation - Inception

This document is intended for administrators or users who want to deploy and use the web infrastructure.

## 1. Services Provided
The stack consists of three interconnected services, each isolated in a dedicated Docker container:
* **NGINX**: The unique entry point (Reverse Proxy) using TLS v1.2/v1.3 to secure communications.
* **WordPress**: The content management system, powered by `php-fpm`.
* **MariaDB**: The relational database that stores all website data.

[Image of a standard 3-tier web architecture Nginx WordPress MariaDB]

## 2. Managing the Project
To manage the lifecycle of the infrastructure, use the `Makefile` located at the root of the repository.

* **To start the project**:
    ```bash
    make
    ```
* **To stop the project (without deleting data)**:
    ```bash
    make stop
    ```

## 3. Accessing the Services
Before accessing the site, ensure your local `/etc/hosts` file contains:
`127.0.0.1 mbenzira.42.fr`

* **Public Website**: [https://mbenzira.42.fr](https://mbenzira.42.fr)
* **Administration Panel**: [https://mbenzira.42.fr/wp-admin](https://mbenzira.42.fr/wp-admin)

## 4. Credentials Management
All sensitive credentials (passwords, logins, DB names) are stored in the **`srcs/.env`** file.
* **Location**: `srcs/.env`
* **Action**: To change a password, modify the value in this file and run `make re`.

## 5. Health Check
To verify that the infrastructure is healthy:
1.  **Check container status**: Run `docker ps`. All containers must be `Up`.
2.  **Check logs**: Run `docker compose -f srcs/docker-compose.yml logs -f`.
3.  **Check Browser**: Access the URL. If you see the "Privacy Error", it is normal (self-signed certificate); click "Advanced" and "Proceed".