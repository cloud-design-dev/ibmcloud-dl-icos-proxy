#!/usr/bin/env bash

## Update machine
DEBIAN_FRONTEND=noninteractive apt-get -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade

## Install Nginx and dependencies
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

## Add Certbot PPA 
DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:certbot/certbot -y 

## Update machine for new ppa and install certbot utility
DEBIAN_FRONTEND=noninteractive apt-get -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' python-certbot-nginx

export FQDN=${fqdn}
export ICOS_ENDPOINT=${private_icos_endpoint}

wget https://raw.githubusercontent.com/cloud-design-dev/ibmcloud-dl-icos-proxy/master/example-nginx.conf -O /etc/nginx/sites-available/${FQDN}

sed -i "s|FQDN_PLACEHOLDER|${FQDN}|" /etc/nginx/sites-available/${FQDN}
sed -i "s|ICOS_ENDPOINT_PLACEHOLDER|${ICOS_ENDPOINT}|" /etc/nginx/sites-available/${FQDN}

## Enable new nginx site 
# ln -s /etc/nginx/sites-available/${FQDN} /etc/nginx/sites-enabled/
# systemctl stop nginx 

/usr/bin/at now + 2 minutes <<END
reboot
END

