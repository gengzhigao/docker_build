sed -i -c "s/emmin.crt/server1.crt/g" /data/nginx/NGINX/nginx/conf.d/*.conf
sed -i -c "s/server.crt/server1.crt/g" /data/nginx/NGINX/nginx/conf.d/*.conf
sed -i -c "s/emmin.key/server1.key/g" /data/nginx/NGINX/nginx/conf.d/*.conf
sed -i -c "s/server.key/server1.key/g" /data/nginx/NGINX/nginx/conf.d/*.conf
docker exec -it NGINX service nginx restart