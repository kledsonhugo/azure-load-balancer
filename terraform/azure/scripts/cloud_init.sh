#!/bin/bash
sudo apt update
sudo apt install apache2 -y
echo '<html><body>More info: <a href="https://github.com/kledsonhugo/app-staticsite-lb-azure">GitHub repo</a></body></html>' > /var/www/html/index.html