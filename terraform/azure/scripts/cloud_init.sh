#!/bin/bash
sudo apt update
sudo apt install apache2 -y
echo "<img src=https://avatars.githubusercontent.com/u/19804195?v=4?s=400>" > /var/www/html/index.html