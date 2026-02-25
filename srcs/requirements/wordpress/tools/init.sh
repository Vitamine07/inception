#!/bin/bash

mkdir -p /run/php
chown www-data:www-data /run/php

cd /var/www/html

sleep 10

if [ ! -f wp-config.php ]; then
    echo "Installation de WordPress en cours..."

    wp core download --allow-root

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url=https://$DOMAIN_NAME \
        --title="Inception 42" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        $WP_USER $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD

    echo "WordPress a été installé avec succès."
else
    echo "WordPress est déjà configuré."
fi

echo "Mise à jour des permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html# 6. Lancement de PHP-premier plan
echo "Démarrage de PHP-FPM sur le port 9000..."
exec /usr/sbin/php-fpm7.4 -F
