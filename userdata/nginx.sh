# adding repository and installing nginx		
apt update
apt install nginx -y
cat <<EOT > vapp
upstream vapp {

 server app01:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vapp;

}

}

EOT

mv vapp /etc/nginx/sites-available/vapp
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/vapp /etc/nginx/sites-enabled/vapp

#starting nginx service and firewall
systemctl start nginx
systemctl enable nginx
systemctl restart nginx
