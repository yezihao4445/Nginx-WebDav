echo "$USER:$(openssl passwd $PASSWD)" > /opt/src/user.passwd
/usr/local/nginx/sbin/nginx
