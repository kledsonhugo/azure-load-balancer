#!/bin/bash
    
echo "Update with latest packages"
sudo apt update
    
echo "Install Apache"
sudo apt install apache2 -y

echo "Install application"
echo "staticsite-lb-multi-cloud - Azure" > /var/www/html/index.html