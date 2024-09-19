#!/bin/bash
    
echo "Update with latest packages"
sudo apt update
    
echo "Install Apache"
sudo apt install apache2 -y

echo "Install application"
echo "Bem vindos ao TDC São Paulo 2024" > /var/www/html/index.html