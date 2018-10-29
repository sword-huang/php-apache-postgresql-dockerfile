http_proxy=http://10.32.25.75:4128
VERSION=7.2.10
docker build -t swordhuang/php:$VERSION-apache-postgresql --build-arg HTTP_PROXY=$http_proxy .
docker push swordhuang/php:$VERSION-apache-postgresql
docker push swordhuang/php:latest 
