#!/usr/bin/bash

sudo apt-get -y install build-essential tcl
cd /tmp
wget http://download.redis.io/releases/redis-5.0.0.tar.gz
tar -xvzf redis-5.0.0.tar.gz
cd redis-5.0.0/
make
make test
make install
mkdir /etc/redis
mkdir -p /var/redis
cp redis.conf /etc/redis/


cat <<EOT >> /etc/systemd/system/redis.service
[Unit]
Description=Redis In-Memory Data Store
After=network.target
[Service]
User=root
Group=root
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always
Type=Forking
[Install]
WantedBy=multi-user.target
EOT
service redis start
service redis status
