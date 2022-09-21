#!/bin/sh

set pfSense_gui_branch=Demo-2_6_0
set pfSense_port_branch=Demo-2_6_0
set product_name=Demo

cd /usr/local/www/nginx/
rm -rf *
mkdir -p packages

# Ports web server for core PKGs (pfSense-base, pfSense-rc, etc...)
ln -s /root/pfsense/tmp/${product_name}_${pfSense_gui_branch}_amd64-core/.latest packages/${product_name}_${pfSense_gui_branch}_amd64-core
# Ports web server for other PKGs
ln -s /usr/local/poudriere/data/packages/${product_name}_${pfSense_gui_branch}_amd64-${product_name}_${pfSense_port_branch} 
packages/${product_name}_${pfSense_gui_branch}_amd64-${product_name}_${pfSense_port_branch} 
# Web server for monitoring ports build
ln -s /usr/local/poudriere/data/logs/bulk/${product_name}_${pfSense_gui_branch}_amd64-${product_name}_${pfSense_port_branch}/latest poudriere

# Allow directory indexing, and configure nginx to start automatically on boot
sed -i '' 's+/usr/local/www/nginx;+/usr/local/www/nginx; autoindex on;+g' /usr/local/etc/nginx/nginx.conf
echo nginx_enable=\"YES\" >> /etc/rc.conf

service nginx restart
