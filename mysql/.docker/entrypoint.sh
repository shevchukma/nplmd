#!/bin/bash

# Получаем переменные с параметрами или используем значения по умолчанию
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-rootpass}
MYSQL_DATABASE=${MYSQL_DATABASE:-mydb}
MYSQL_USER=${MYSQL_USER:-user}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-userpass}

# Запускаем MySQL
echo "Запускаем MySQL"
/usr/sbin/mysqld --user=mysql --datadir=/var/lib/mysql --initialize
#--skip-networking --initialize &
echo "Ожидаем запуска MySQL"
# Ожидаем запуска MySQL
while [ ! -e /run/mysqld/mysqld.sock ]; do
    sleep 1
done
#/usr/sbin/mysqld --user=mysql --datadir=/var/lib/mysql &
#sleep 60
#Меняем пароль

echo "Меняем пароль"
temp_password=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
mysql -u root -p$temp_password --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
echo "Создаем базу данных и пользователя"
# Создаем базу данных и пользователя
mysql -u root -p${MYSQL_ROOT_PASSWORD}<<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
echo "Останавливаем MySQL, чтобы ENTRYPOINT не завершался"
# Останавливаем MySQL, чтобы ENTRYPOINT не завершался
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
echo "Запускаем MySQL снова для нормальной работы контейнера"
# Запускаем MySQL снова для нормальной работы контейнера
exec /usr/sbin/mysqld --user=mysql --datadir=/var/lib/mysql
