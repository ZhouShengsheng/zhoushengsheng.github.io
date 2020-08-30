# Docker常用命令

## 容器相关

运行docker容器：
```bash
docker run image command
# 运行ubuntu bash：docker run -it ubuntu:16.04 bash
# 指定名称：--name name
# 映射端口（可指定多个）：-p 8080:8080
# 自动重新启动（开机也会重启）：--restart=always
```

查询docker容器：
```bash
docker ps
```

启动、停止、杀死、重启docker容器：
```bash
docker start container
docker stop container
docker kill container
docker restart container
```

进入docker容器：
```bash
docker exec -it container bash
```
注：有些容器默认没有安装`bash`比如alpine linux，那么也可以试试`sh`.

复制文件到docker容器，或者从docker容器中复制文件到本地：
```bash
docker cp /path/to/file container:/path/to/file
docker cp container:/path/to/file /path/to/file
```

强制删除容器并杀死进程：
```bash
docker rm -f container
```

查询容器log：
```bash
docker logs container
```

获取容器ip地址：

```bash
docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" container
```

## 镜像相关

强制删除镜像并移除相关容器：
```bash
docker rmi -f image
```

批量删除镜像：
```bash
docker images | grep something | awk '{print $3}' | xargs docker rmi -f
```

## docker-compose相关

启动docker-compose：
```bash
docker-compose up -d
```

指定配置文件启动：
```bash
docker-compose -f docker-compose-conf.yml up -d
```

重启服务：
```bash
docker-compose restart service
docker-compose -f docker-compose-conf.yml restart service
```

强制拉取最新镜像：
```bash
docker-compose pull service
```

## 仓库相关

指定用户名密码登陆仓库：
```bash
docker login -u user -p password registry_address:port
```

给镜像打tag到私有仓库：
```bash
docker tag image:tag registry_address:port/image:tag
# 例如：
docker tag cws-retail/cws-retail-web:0.0.1 localhost:5000/cws-retail/cws-retail-web:0.0.1
```
