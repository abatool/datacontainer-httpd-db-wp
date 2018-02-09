#/bin/bash
echo "------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------Creation of a new network called wpnet.--------------------------------------"
echo "------------------------------------------------------------------------------------------------------"

docker network create wpnet

 
echo "------------------------------------------------------------------------------------------------------"
echo "----------Creating a container named datacontainer with the image abatool1/datacontainer-httpd-db-wp which maps volumes /var/www/html for apache and /var/lib/mysql for mariadb.---------------"
echo "------------------------------------------------------------------------------------------------------"

docker create --name datacontainer --network wpnet abatool1/datacontainer-httpd-db-wp

echo "------------------------------------------------------------------------------------------------------"
echo "----------Creating a container of mariadb based image named db with orboan/dcsss-mariadb image and using datacontainer volumes.---------------"
echo "------------------------------------------------------------------------------------------------------"

docker run --name db -d -p 3306:3306 --network wpnet -e MYSQL_ROOT_PASSWORD=wproot -e MYSQL_DATABASE1=wordpress -e MYSQL_USER1=wpuser -e MYSQL_PASSWORD1=wppass --volumes-from datacontainer orboan/dcsss-mariadb

echo "------------------------------------------------------------------------------------------------------"
echo "----------Create an apache-based container called apache2 with image abatool1/httpd-php using volumes of the datacontainer---------------"
echo "------------------------------------------------------------------------------------------------------"

docker run--name apache2 -d -p 8080:80 --network wpnet --volumes-from datacontainer abatool1/httpd-php


