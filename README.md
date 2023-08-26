1. Установить докер:
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf repolist
yum remove docker docker-* podman runc
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable --now docker
systemctl status docker

2. Скачать файлы
git clone ...

3. Собрать и запустить nginx+php
cd ./nginx
docker build -t mynginx:0.1 . --no-cache
docker run -d -p 80:80 mynginx:0.1 --name mynginx-container
cd ..

4. Собраить и запустить mysql
cd ./mysql
docker build -t mymysql:0.1 .
docker run --rm -d -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=myrootpass \
    -e MYSQL_DATABASE=mydb \
    -e MYSQL_USER=myuser \
    -e MYSQL_PASSWORD=mypassword \
    --name mymysql-container mymysql:0.1

*** Полезные командны ***
#Удалить образы
docker image prune -a
#Войти в контейнер
docker exec -it mymysql-container bash
