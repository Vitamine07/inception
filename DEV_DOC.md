# 🛠 Developer Documentation - Inception

This document describes the technical architecture and commands for maintaining the project.

## 1. Environment Setup
### Prerequisites
* **OS**: Debian or any Linux distribution with `apt`.
* **Tools**: `make`, `docker`, `docker-compose`.
* **Disk Structure**: Create the data directories manually if not handled by your script:
    `sudo mkdir -p /home/mbenzira/data/mariadb /home/mbenzira/data/wordpress`

### Secrets & Config
* The project relies on environment variables defined in `srcs/.env`. 
* **Dockerfiles**: Located in `srcs/requirements/`. Each service has its own build context.

## 2. Build and Launch
The infrastructure is orchestrated using Docker Compose. The `Makefile` wraps these commands:
* `make all`: Triggers `docker compose up --build`.
* `make fclean`: Triggers `docker stop`, `docker rm`, and `docker volume rm`. This is the "hard reset" required for the evaluation.



## 3. Advanced Management Commands
These commands are essential for debugging during the evaluation:

| Task | Command |
| :--- | :--- |
| **Inspect DB content** | `docker exec -it mariadb mysql -u root -p` |
| **Check WP users** | `docker exec -it wordpress wp user list --allow-root` |
| **Check Nginx Config** | `docker exec -it nginx nginx -T` |
| **Network isolation** | `docker network inspect srcs_inception_network` |

## 4. Data Persistence & Storage
Persistence is achieved using **Bind Mounts**. This choice allows the data to survive container destruction while remaining accessible on the host for backups.

* **Internal Path (Container)**: `/var/lib/mysql` and `/var/www/html`
* **Host Path (Physical)**: `/home/mbenzira/data/mariadb` and `/home/mbenzira/data/wordpress`



### Logic flow:
When `make` is called, Docker mounts the host directory into the container. If the directory is empty (first launch), the `init.sh` script (ENTRYPOINT) populates the database and installs WordPress via WP-CLI.