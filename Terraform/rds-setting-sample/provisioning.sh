#!/bin/sh
export MYSQL_HOST=${DB_HOST_IP}
export MYSQL_DATABASE=${DB_NAME}
export MYSQL_USER=${DB_USER}
export MYSQL_PASSWORD=${DB_PASSWORD}

sudo yum install -y yum-utils unzip mysql
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install docker-ce
curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "version: '3'" >> docker-compose.yml
echo "services:" >> docker-compose.yml
echo "  # MySQL" >> docker-compose.yml
echo "  db:" >> docker-compose.yml
echo "    image: mysql:5.7" >> docker-compose.yml
echo "    container_name: mysql_host" >> docker-compose.yml
echo "    environment:" >> docker-compose.yml
echo "     - MYSQL_HOST=db_host" >> docker-compose.yml
echo "     - MYSQL_DATABASE=db_name" >> docker-compose.yml
echo "     - MYSQL_USER=db_user" >> docker-compose.yml
echo "     - MYSQL_PASSWORD=db_password" >> docker-compose.yml
echo "     - TZ='Asia/Tokyo'" >> docker-compose.yml
echo "    command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci" >> docker-compose.yml
echo "    volumes:" >> docker-compose.yml
echo "      - ./docker/db/data:/var/lib/mysql" >> docker-compose.yml
echo "      - ./docker/db/my.cnf:/etc/mysql/conf.d/my.cnf" >> docker-compose.yml
echo "      - ./docker/db/sql:/docker-entrypoint-initdb.d" >> docker-compose.yml
echo "    ports:" >> docker-compose.yml
echo "    - 3306:3306" >> docker-compose.yml
sed -i "s/=db_host/='$MYSQL_HOST'/g" docker-compose.yml
sed -i "s/=db_name/='$MYSQL_DATABASE'/g" docker-compose.yml
sed -i "s/=db_user/='$MYSQL_USER'/g" docker-compose.yml
sed -i "s/=db_password/='$MYSQL_PASSWORD'/g" docker-compose.yml

sudo service docker start
docker-compose up -d
