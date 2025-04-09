#!/bin/bash
sudo apt update
sudo apt install apache2 -y
echo "More info: https://github.com/kledsonhugo/app-staticsite-lb-azure" > /var/www/html/index.html