# 网络相关命令

查询监听端口:
```bash
# 使用lsof
lsof -i | grep port
lsof -i:port

# 使用netstat
#   -t (tcp)显示tcp相关端口
#   -u (udp)显示udp相关端口
#   -n 拒绝显示别名，尽量显示为数字形式
#   -l (listen)仅显示监听状态的端口
#   -p 显示建立连接的进程名
netstat -tunlp | grep port
```

wget指定下载文件名:
```bash
# 使用-O参数指定输出路径与文件名
wget http://test-url.com/test_v0.zip -O test.zip

```

查询并过滤出IP地址:
```bash
# 首先用ifconfig（或ip a）查询，然后复制ip地址的一段到如下命令的grep后面：
ifconfig | grep 149 | awk '{print $2}' | sed 's/addr://g'
# 或者：
ip a | grep 149 | awk '{print $2}' | sed "s/\/.*//g"
```

获取路由器公网IP:
```bash
curl ifconfig.me
```
