# Используем образ CentOS 8 как базовый образ
FROM centos:8

# Устанавливаем необходимые пакеты
RUN cd /etc/yum.repos.d/ && \
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
#dnf install -y https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-8.0.33-25/binary/redhat/8/x86_64/percona-server-shared-compat-8.0.33-25.1.el8.x86_64.rpm && \
#dnf install -y https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-8.0.33-25/binary/redhat/8/x86_64/percona-server-shared-8.0.33-25.1.el8.x86_64.rpm && \
#dnf install -y https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-8.0.33-25/binary/redhat/8/x86_64/percona-icu-data-files-8.0.33-25.1.el8.x86_64.rpm && \
#dnf install -y https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-8.0.33-25/binary/redhat/8/x86_64/percona-server-client-8.0.33-25.1.el8.x86_64.rpm && \
#dnf install -y https://www.percona.com/downloads/Percona-Server-LATEST/Percona-Server-8.0.33-25/binary/redhat/8/x86_64/percona-server-server-8.0.33-25.1.el8.x86_64.rpm && \
yum install -y https://repo.percona.com/yum/percona-release-latest.noarch.rpm && \
percona-release setup -y ps-80 && \
yum install -y percona-server-server && \
#yum install -y https://repo.percona.com/yum/percona-release-latest.noarch.rpm && \
#percona-release setup ps-80 && \
#yum install -y percona-server-server && \
    dnf clean all && \
    mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Копирование скрипта и конфигурационных файлов в образ
COPY .docker/my.cnf /etc/my.cnf
COPY .docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Открытие порта для доступа к MySQL
EXPOSE 3306

# Запуск скрипта при старте контейнера
ENTRYPOINT ["/entrypoint.sh"]
