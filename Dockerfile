FROM dockerimages/ubuntu-core:14.04
MAINTAINER Frank Lemanschik
ENV DOCKER_RUN 'docker run -d h1.dspeed.eu:5000/php-pp'
ENV DOCKER_BUILD 'docker build -t h1.dspeed.eu:5000/php-pp git://github.com/frank-dspeed/PHP-PP'
# ADD http://packages.couchbase.com/clients/c/libcouchbase-2.4.1_ubuntu1404_amd64.tar /libcouchbase
ADD . /var/www/html
RUN apt-get update && apt-get install wget \
 && wget -O/etc/apt/sources.list.d/couchbase.list http://packages.couchbase.com/ubuntu/couchbase-ubuntu1404.list \
 && wget -O- http://packages.couchbase.com/ubuntu/couchbase.key | sudo apt-key add - \
 && apt-get update && apt-get install libcouchbase2-libevent libcouchbase-dev php-pear build-essential php5 apache2 \
 && pecl install couchbase
#Update php.ini with extension=couchbase.so.
#Restart Apache # sudo service apache2 restart.
