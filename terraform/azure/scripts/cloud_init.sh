#!/bin/bash
sudo apt update
sudo apt install apache2 -y
echo "More info: <a href=https://github.com/kledsonhugo/app-staticsite-lb-azure>GitHub Repository</a>" > /var/www/html/index.html