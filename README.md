#### Предварительные действия
##### Подготовить репозиторий Centos 8
```
cd /etc/yum.repos.d/ && sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
```
##### Обновление и установка пакетов
```
yum update -y && yum install -y epel-release && yum install -y vim screen git
```

#### Установить докер:
```
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf repolist
yum remove docker docker-* podman runc
yum install -y docker-ce docker-ce-cli containerd.io
systemctl enable --now docker
systemctl status docker
```
#### Git
##### Добавить ключ
```
ssh-keygen -t ed25519 -C "velikoross@gmail.com"
```
Внести в [github](https://github.com/settings/keys)
```
git clone git@github.com:shevchukma/nplmd.git
```

#### Собрать и запустить nginx+php
```
cd ./nginx
docker build -t mynginx:0.1 . --no-cache
docker run -d -p 80:80 mynginx:0.1 --name mynginx-container
cd ..
```

#### Собраить и запустить mysql
```
cd ./mysql
docker build -t mymysql:0.1 .
docker run --rm -d -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=myrootpass \
    -e MYSQL_DATABASE=mydb \
    -e MYSQL_USER=myuser \
    -e MYSQL_PASSWORD=mypassword \
    --name mymysql-container mymysql:0.1
```

#### Полезные командны
##### Удалить образы
```
docker image prune -a
```

##### Войти в контейнер
```
docker exec -it mymysql-container bash
```
#### Работа в Git
Установка личных данных
```
git config --global user.email "veleikoross@gmail.com"
git config --global user.name "Maxim Shevchuk"
```
Подключение репозитория
```
git branch -M main
git remote add origin git@github.com:shevchukma/nplmd.git
git push -u origin main
```
