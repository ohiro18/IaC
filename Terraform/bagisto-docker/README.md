# Bagisto 

```yml

version: '3'

services:

  web_server:
    image: webkul/apache-php:latest
    container_name: apache2
    restart: always
    volumes:
      - ./app:/var/www/html
    working_dir: /var/www/html/
    environment:
      USER_UID: 'mention your system user ID here. ex: 1001, 1000, 33, etc'
    networks:
      - bagisto-network
    ports:
      - '80:80'
    expose:
      - '80'
    depends_on:
      - database_server
    links:
      - database_server

  database_server:
    image: mysql:5.7
    container_name: mysql
    restart: always
    environment:
      MYSQL_DATABASE: 'mention the name of the database to be created here. eg: mydatabase'
      MYSQL_USER: 'mention database user here. eg: mydatabase_user'
      MYSQL_PASSWORD: 'mention database user password here. ex: mystrongPassword'
      MYSQL_ROOT_PASSWORD: 'mention mysql root password here. ex: mysqlstrongpass'
      MYSQL_ROOT_HOST: '%'
    networks:
      - bagisto-network
    ports:
      - '3306:3306'
    expose:
      - '3306'
    volumes:
      - ./dbvolume:/var/lib/mysql

volumes:
  dbvolume:
  app:

networks:
  bagisto-network:

```
