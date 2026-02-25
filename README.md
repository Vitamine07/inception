Inception - 42 Project
This project has been created as part of the 42 curriculum by [mbenzira].
Description
Inception is a System Administration project that aims to broaden the knowledge of virtualization by using Docker. The goal is to set up a small infrastructure composed of several services, all running in their own dedicated containers within a virtual machine.
The infrastructure consists of:
    • NGINX (TLS v1.2/v1.3 only).
    • WordPress (running with php-fpm, without Nginx in the same container).
    • MariaDB (Database).
    • All services are built from Debian Bullseye to ensure a deep understanding of service configuration without using "pre-made" images.
Project Description & Design Choices
The project is structured to enforce the Principle of Least Privilege and service isolation. Every service runs in its own container, communicating via a private network.
Design Choices
    • Init Scripts: Custom entrypoints are used to ensure MariaDB and WordPress are configured automatically (database creation, user setup via WP-CLI) before the services start in the foreground.
    • PID 1 Management: Services are launched using exec to ensure they receive signals correctly and remain the primary process of the container.
Technical Comparisons
Feature	Comparison
Virtual Machines vs Docker	VMs virtualize hardware and run a full OS, making them heavy. Docker virtualizes the OS kernel, sharing the host's kernel, which makes containers lightweight and fast.
Secrets vs Env Variables	Environment variables are easy to use but can be leaked via process logs. Docker Secrets (or encrypted files) provide a more secure way to handle sensitive data like DB passwords.
Docker Network vs Host Network	Host network shares the host's IP/ports directly (less secure). Docker Network (Bridge) creates an isolated virtual network where containers can only see each other via internal DNS.
Docker Volumes vs Bind Mounts	Volumes are managed by Docker (best for performance/backups). Bind mounts map a specific host path to a container, useful here to persist data in /home/mbenzira/data.
Instructions
Prerequisites
    • A Linux Virtual Machine (Debian recommended).
    • Docker and docker-compose installed.
    • Local domain mapping in /etc/hosts: 127.0.0.1 mbenzira.42.fr
Compilation & Execution
Go to the root of the repository and use the provided Makefile:
Bash
# To build and start the infrastructure
make

# To stop the containers
make down

# To clean all data (volumes, images, networks)
make fclean

# To rebuild everything
make re
Resources
    • Docker Documentation
    • NGINX TLS Configuration
    • WordPress CLI (WP-CLI)
    • MariaDB Knowledge Base
Use of AI
Gemini was used as a collaborative peer during this project for the following tasks:
    • Debugging: Identifying "Connection reset by peer" errors related to PHP-FPM socket permissions.
    • Architecture Design: Explaining the difference between ENTRYPOINT and CMD to comply with the 42 subject constraints (no background processes).
    • Scripting: Assisting in the logic for the MariaDB initialization script to ensure the service stays in the foreground.
    • Documentation: Structure and technical proofreading of this README.
