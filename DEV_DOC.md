🛠 Developer Documentation - Inception Internal Project

This document details the technical architecture, workflow, and debugging procedures for the Inception infrastructure.

1. Environment Configuration

Prerequisites

To replicate this environment, the following tools must be installed on a Linux host (Debian Bullseye recommended):

Docker Engine (v20.10+)

Docker Compose (v2.0+)

GNU Make

Local Domain Mapping: Add the following line to your /etc/hosts file:

127.0.0.1 mbenzira.42.fr


Secrets and Configuration

The project uses a central .env file located in the srcs/ directory. This file must define:

DOMAIN_NAME: The site URL (e.g., mbenzira.42.fr).

SQL_DATABASE, SQL_USER, SQL_PASSWORD, SQL_ROOT_PASSWORD: For MariaDB configuration.

WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_USER, WP_USER_PASSWORD: For WordPress initialization.

2. Workflow (Build & Launch)

The project is managed via a Makefile at the root of the repository. This ensures consistency in commands for building and cleaning the environment.

Command

Action

make

Builds Docker images and starts all services in the background.

make stop

Pauses running containers.

make down

Stops and removes containers and networks.

make fclean

The Evaluation Reset: Stops everything and deletes images, networks, and volumes.

make re

Forces a full reconstruction of the entire infrastructure.

3. Data Persistence (Bind Mounts)

Persistence is managed via Bind Mounts to link host directories to container directories. This allows data to survive container deletion.

Host Paths:

/home/mbenzira/data/mariadb

/home/mbenzira/data/wordpress

Container Paths:

MariaDB: /var/lib/mysql

WordPress: /var/www/html

Why Bind Mounts? They allow the administrator to manage files directly from the mbenzira host system without needing to explore Docker's internal storage.

4. Database Inspection (MariaDB)

During evaluation, you will need to prove the database is functional and contains the correct data.

Step 1: Access the MariaDB CLI

Run this command from your host terminal:

docker exec -it mariadb mysql -u root -p


(Enter the ROOT password defined in your .env file when prompted).

Step 2: Essential SQL Queries for Debugging

Once inside the MariaDB prompt:

-- List all databases
SHOW DATABASES;

-- Access the specific WordPress database
USE wordpress_db;

-- List all tables (verify that WordPress created its tables)
SHOW TABLES;

-- Verify that WordPress users were created by the init script
SELECT user_login, user_email FROM wp_users;

-- Exit the database
exit


5. Docker Management and Debugging

Use these commands to monitor the status and health of the infrastructure:

View all logs in real-time: docker compose -f srcs/docker-compose.yml logs -f

Check service status: docker ps (Ensure all containers are 'Up').

Inspect the network: docker network inspect srcs_inception_network (Verify isolation).

WordPress verification via CLI:

docker exec -it wordpress wp user list --allow-root


6. Technical Design Choices

PID 1 Management: All services are launched via the exec command in their respective entrypoint scripts. This ensures that system signals (like SIGTERM) are handled correctly.

No Background Processes: As required by the 42 subject, no service runs in the background. Everything runs in the foreground to keep the container active and responsive to logs.

Network Security: Containers share a dedicated bridge network. The database is intentionally not exposed on any host port.