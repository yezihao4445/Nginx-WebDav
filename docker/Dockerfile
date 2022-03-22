FROM alpine:latest

COPY src /opt/src

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && apk add --no-cache gcc g++ make pcre pcre-dev zlib zlib-dev libxslt libxslt-dev openssl-dev && \
    cd /opt/src/nginx-1.18.0 && \
    ./configure --prefix=/usr/local/nginx --with-http_dav_module --add-module=/opt/src/nginx-dav-ext-module --with-http_ssl_module && \
    make

FROM alpine:latest

COPY --from=0 /opt/src /opt/src

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && apk add --no-cache make pcre zlib libxslt openssl && \
    cd /opt/src/nginx-1.18.0 && \
    make install && \
    mkdir /data && \
    chown nobody:nobody /data && \
    chmod -R 700 /data && \
    chmod +x /opt/src/run.sh && \
    mv /opt/src/cert /usr/local/nginx/conf/cert && \
    ls /opt/src | grep run.sh | xargs rm -rf && \
    ln -sv /usr/local/nginx/sbin/nginx   /usr/local/bin/nginx

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

CMD ["/bin/sh", "-c", "/opt/src/run.sh && tail -f /var/log/webdav.log"]
