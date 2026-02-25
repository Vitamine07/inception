📘 User Documentation - Inception Project

This document provides clear and simple instructions on how to use, manage, and verify the Inception web infrastructure.

1. Services Overview

The infrastructure (or "stack") is composed of three main services working together to provide a secure web environment:

NGINX: The secure web server. It acts as the entry point for all traffic, handling encryption (TLS v1.2/v1.3) to keep your data safe.

WordPress: The Content Management System (CMS). This is the engine that allows you to create, manage, and read website articles. It runs using php-fpm.

MariaDB: The database. This is where all the website's data (posts, users, comments, and settings) is securely stored.

2. Managing the Project

You can control the entire infrastructure using simple commands from the root of the project folder.

To start the project (build and launch):

make


To stop the project (without deleting your data):

make stop


To shut down and clean up (removes containers and network):

make down


3. Accessing the Website

Local Configuration

Before connecting for the first time, you must ensure your computer recognizes the site's address. The domain name used is: mbenzira.42.fr.

Public Website

To view the website, open your browser and go to:
👉 https://mbenzira.42.fr

Administration Panel

To manage the site, add posts, or manage users, access the admin interface:
👉 https://mbenzira.42.fr/wp-admin

4. Credentials Management

For security reasons, no passwords or usernames are written directly in the project code.

Location: All usernames and passwords are grouped in the following hidden file: srcs/.env.

Management: If you need to change a password (for the database or the WordPress admin), modify the values in this file, then restart the project using the command make re.

5. Verifying Service Health

If the website is unreachable, you can check the health of the services using these methods:

Quick Status Check

Run the following command in your terminal:

docker ps


You should see three lines (nginx, wordpress, mariadb). The STATUS column should indicate Up for all of them.

Error Logs

If a service is stopped or behaving unexpectedly, you can read the error logs by typing:

docker compose -f srcs/docker-compose.yml logs -f


SSL Security Note

During the first connection, your browser will show a security warning ("Your connection is not private"). This is normal because we use a self-signed certificate. Click on Advanced and then Proceed to mbenzira.42.fr.