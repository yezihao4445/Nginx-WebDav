# 基于alpine docker 容器的简易nginx-WebDav
---
## 快速启动
* 需要环境中拥有docker、docker-compose
```
docker load -i webdav.tar.gz
docker-compose up -d
```
* 通过 https://IP 访问WebDAV。默认账户密码为admin admin
---
## 项目结构
```
├── docker 构建镜像
│   ├── Dockerfile
│   ├── build.yml
│   ├── nginx.conf  nginx配置文件
│   └── src  镜像内部资源
│       ├── cert  开启https所需证书，容器中路径为 /usr/local/nginx/conf/cert
│       ├── nginx-1.18.0 nginx源码
│       ├── nginx-dav-ext-module nginx WebDav 模块源码
│       └── run.sh 镜像运行脚本
├── docker-compose.yml
└── readme.md
```
---
## 构建镜像
```
cd docker
docker-compose -f build.yml build
```
* 镜像大小在35MB左右
---
## 运行参数
```
version: "3.3"
services:
  webdav:
    image: webdav:yz
    restart: always
    volumes:
      - /path/to/data:/data   #存储文件挂载
      # - /path/to/cert:/usr/local/nginx/conf/cert # nginx开启TLS验证
    environment:
      - USER=admin       # 账户
      - PASSWD=admin     # 密码
    ports:
      - 443:443          #映射端口
    container_name: webdav

```
---
## 运行容器
```
docker-compose up -d
```
---
## PS

* Windows11 下测试挂载成功(http\https皆可。https要求证书配置(Common Name)必须严格对应才可挂载)
* MAC 下测试通过 FE File Explorer ，其余工具请自行验证
