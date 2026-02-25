📘 User Documentation – Inception Project

This document provides clear and simple instructions on how to use, manage, and verify the Inception web infrastructure.

🏗 Services Overview

The infrastructure (or stack) is composed of three main services working together to provide a secure web environment:

🌐 NGINX

The secure web server.
It acts as the entry point for all traffic, handling encryption (TLS v1.2 / TLS v1.3) to keep your data safe.

📝 WordPress

The Content Management System (CMS).
This is the engine that allows you to create, manage, and read website articles.
It runs using php-fpm.

🗄 MariaDB

The database service.
This is where all the website's data (posts, users, comments, and settings) is securely stored.

🛠 Managing the Project

You can control the entire infrastructure using simple commands from the root of the project folder.

▶️ Start the Project (Build & Launch)
make

Builds Docker images and launches all services.

⏸ Stop the Project (Without Deleting Data)
make stop

Stops running containers but keeps your data intact.

🧹 Shut Down and Clean Up
make down

Stops and removes containers and the network.

🌍 Accessing the Website
⚙️ Local Configuration

Before connecting for the first time, ensure your computer recognizes the site’s address.

Add this line to your /etc/hosts file:

127.0.0.1 mbenzira.42.fr
🌐 Public Website

To view the website, open your browser and go to:

👉 https://mbenzira.42.fr

🔐 Administration Panel

To manage the site, add posts, or manage users:

👉 https://mbenzira.42.fr/wp-admin

🔑 Credentials Management

For security reasons, no passwords or usernames are written directly in the project code.

📂 Location

All usernames and passwords are grouped in the following hidden file:

srcs/.env
🔄 Updating Credentials

If you need to change a password (database or WordPress admin):

Modify the values inside srcs/.env

Restart the project with:

make re
🩺 Verifying Service Health

If the website is unreachable, you can check the health of the services using the following methods.

🔍 Quick Status Check
docker ps

You should see three containers:

nginx

wordpress

mariadb

The STATUS column should indicate:

Up

for all services.

📜 Error Logs

If a service is stopped or behaving unexpectedly, check the logs:

docker compose -f srcs/docker-compose.yml logs -f

This will display real-time logs for troubleshooting.

🔒 SSL Security Note

During the first connection, your browser may show a security warning:

"Your connection is not private"

This is normal because the project uses a self-signed SSL certificate.

To proceed:

Click Advanced

Click Proceed to mbenzira.42.fr

DONE !