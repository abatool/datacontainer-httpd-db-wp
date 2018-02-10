# Pull base image.
FROM centos 

#Create documentroot directory for apache.
RUN mkdir -p /var/www/html 

#Create documentroot directory for mariadb.
RUN mkdir -p /var/lib/mysql

#Creating user and group apache with uid and guid.
RUN groupadd -g 107 apache
RUN useradd -u 107 -g 107 apache
 
#Declare the work directory
WORKDIR ["/var/www/html"]

#Install wget.
RUN yum install wget -y && \

#Enter in the directory /var/www/html
cd /var/www/html && \

#Installation of latest version of wordpress.
wget https://wordpress.org/latest.tar.gz && \

#Extract the wordpress directory.
tar -xvf latest.tar.gz && \

#As we already extract the wordpress directory we delete the latest.tar.gz file.
rm -f latest.tar.gz && \

#Copy all the files from the /var/www/html/wordpress directory to /var/www/html.
mv  /var/www/html/wordpress/* /var/www/html && \

#Delete wordpress directory.
rm -rf wordpress/ && \

#Recursively change the owner of /var/www/html to apache.
chown -R apache:apache /var/www/html && \

#Recursively change the permission of directory /var/www/html to 755.
chmod -R 755 /var/www/html

#Difine mountable directories.
VOLUME ["/var/www/html" , "/var/lib/mysql"]

