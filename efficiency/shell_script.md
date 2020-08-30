# Shell Script – 提高工作效率的必备神器

## 引言

想必天天跟电脑打交道的各位IT工作党，多少都有过下列类似的经历：

1. 每天都要cd到好几个工程里面，git pull拉取代码；
查看一个项目的log，要输入一大串指令(比如tail -f /home/tester/app/log/app-2017-06-10.log)，而且经常会忘记log在哪，文件名有什么规则；
2. 为了将新代码部署到服务器上，要先打包工程，然后scp新的可执行文件到服务器上，再ssh登陆到服务器上重新运行代码；
3. 重启一个自己写的运行在服务器上的程序，首先ps配合grep查到那个程序的pid，然后kill，然后还要再ps一下确认进程有没有真的被杀死。
4. 上面所提到的这些经历，不管是程序员、运维人员、架构师还是研究员，都可能遇到。这些工作都不难，只要熟悉命令行，都可以完成。可是这些工作做的太多了就会觉得很烦...

就拿第一个来举例，一名程序员每天来办公室的第一件事，就是更新他所负责的所有项目的代码，负责的项目少还好，项目多的话那真的太烦了。小编在公司里面负责后端开发，手上的工程有18个，每天早上更新代码，要cd到18个文件夹里面，然后运行git pull，首先这个过程比较麻烦，重复cd和git pull，其次这个过程比较耗时，差不多要10分钟左右。这件事情完全可以用shell script来代替，实际上小编每天都会用自己写的一个脚本来pull所有工程的代码，只要运行这个脚本，所有项目的代码都会更新到最新状态，操作只有一步，那就是运行这个脚本，整个过程仅仅耗时几十秒。这一个简单的shell script大大简化了更新项目代码的工作流程，提高了工作效率。

上面提到的几个用例，都是一些机械、重复或者带一点逻辑控制的操作，这样的操作我们都可以用shell script来代替。

## Shell Script简介

Shell script既是一种编程语言，又是一种可在UNIX-like操作系统下执行的脚本文件，类似于Windows系统中的批处理文件。我们可以将一些简单、重复的操作写成shell script，让机器来做一些本来需要我们手动做的事情。另外shell script还提供了分支、循环等这些与其他高级编程语言类似的流程控制，丰富了脚本的开发，让我们更好地处理事务。Shell script主要用来做自动化处理，也可以帮助我们做一些简单的数据分析。当然，既然它是一门编程语言，你当然可以用它来写复杂的程序，不过shell script的执行效率远不如像C/C++/Java这样的高级语言，所以一般不会用它来做复杂的业务开发。

## Shell Script实际应用

这一章里面，小编就带大家实际动手开发一个shell script来完成服务器Java程序启动、关闭与重启的任务。脚本名称service.sh，内容如下：

```bash
#!/usr/bin/env bash
# Desc: Script to start, stop or restart service.
# Author: Zhou Shengsheng
# Date: 20/06/17
# Version: 1.0.0

#=================================
# Configurations
#=================================

# jdk
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
JRE_HOME=${JAVA_HOME}/jre


# service config
SERVICE_NAME=app
SERVICE_WORKSPACE=/home/tester
SERVICE_JAR_FILE=${SERVICE_WORKSPACE}/${SERVICE_NAME}.jar
SERVICE_PID_FILE=${SERVICE_WORKSPACE}/${SERVICE_NAME}.pid

# jvm config
JVM_ARGS="-Xms256m -Xmx256m"
PROFILE="dev"

# shell config
set -o pipefail
set -o nounset

#=================================
# Functions
#=================================

function printUsage() {
    echo "usage: $0 [start|stop|restart]"
}

function startService() {
    echo "===> starting ${SERVICE_NAME}"
    nohup ${JRE_HOME}/bin/java ${JVM_ARGS} -jar -Dspring.profiles.active=${PROFILE} ${SERVICE_JAR_FILE} >/dev/null 2>&1 &
    echo $! > ${SERVICE_PID_FILE}
}

function stopService() {
    echo "===> stopping ${SERVICE_NAME}"
    kill `cat ${SERVICE_PID_FILE} 2> /dev/null` 2> /dev/null
    rm -rf ${SERVICE_PID_FILE}
    maxTimeout=30 # in seconds
    servicePid=-1
    startTime=`date +%s`

    while [[ -n ${servicePid} ]];
    do
        servicePid=`ps -ef | grep -w "${SERVICE_JAR_FILE}" | grep -v "grep" | awk '{print $2}'`
        if [[ -n ${servicePid} ]]; then
            kill ${servicePid} 2> /dev/null
            sleep 1
            curTime=`date +%s`
            timeout=$(( ${curTime} - ${startTime} ))
            if [[ ${timeout} -ge ${maxTimeout} ]]; then
                kill -9 ${servicePid} 2> /dev/null
                servicePid=""
            fi
        fi
    done
}

function restartService() {
    stopService
    startService
}

#=================================
# Checks
#=================================

# check jre
if [[ ! -x ${JRE_HOME}/bin/java ]]; then
    >&2 echo "jre checking failure"
    exit 1
fi

# check service jar file
if [[ ! -r ${SERVICE_JAR_FILE} ]]; then
    >&2 echo "jar file ${SERVICE_JAR_FILE} checking failure"
    exit 1
fi

#=================================
# Service start, stop and restart
#=================================

cd ${SERVICE_WORKSPACE}

if [[ $# -eq 0 ]]; then
    restartService
else
    case "$1" in
        start)
            startService
            ;;
        stop)
            stopService
            ;;
        restart)
            restartService
            ;;
        -h)
            printUsage
            ;;
        *)
            >&2 echo "invalid argument"
            printUsage
            exit 1
            ;;
    esac
fi
```
脚本头部是一些对脚本的注释信息，包含运行环境、描述、作者、日期和版本号，这是所有脚本都应该包含的内容。**脚本代码分为配置、函数、检测、事务四部分**：

1. 在配置里面，我们配置了JDK、service、JVM以及shell script环境，之所以将这些配置抽离出来，是为了可以适应到不同环境或者不同机器。
2. 在函数部分，我们定义了四个函数：打印用法、启动服务、关闭服务与重启服务。启动服务时，**我们用nohup以后台的方式来运行java程序，这样可以保证父shell退出不会导致java进程结束**。启动完毕后，我们将java进程的pid写入文件中，方便以后结束进程，同时也为其他中间件系统(比如进程监控系统)的接入提供便利之处。在关闭服务函数中，我们首先读取pid文件，使用kill命令来杀死该进程，随后我们做了一个循环检测该进程是否已经结束，**因为kill一个进程，实际上是向进程发送SIGTERM信号，进程会有一个关闭的过程(释放资源等)**，有些进程可能会无法正常关闭。我们每秒钟检测一次进程是否结束，**如果检测超过最大超时时间该进程还没有结束，那么我们就kill -9强制杀死该进程**(kill -9实际上是向进程发送SIGKILL信号，进程一定会被强制杀死)。
3. 检测部分，我们对一些可能影响到服务启动的必要依赖进行检测，保证服务可以正常启动。
4. 在事务部分，我们对脚本接收到的命令行参数进行解析，来执行不同的函数，达到预期的功能。
该脚本的用法也十分简单:

```
输出用法: ./service.sh -h
启动服务: ./service.sh start
关闭服务: ./service.sh stop
重启服务: ./service.sh restart
```

有了这个脚本，是不是感觉服务启动、关闭、重启一下子就变得很简单了？其实Linux下面很多服务启动、关闭、重启都是用类似的方法做的。小编所在的公司，后端所有的项目也用了类似的启动脚本，配合Jenkins(一个持续集成系统)，可以实现服务的一键部署。

## 如何学习Shell Script

看到这里，是不是也想自己写点shell script来提高自己的工作效率呢？这一章节就来告诉你，该怎样学习shell script：

1. **Linux的基础要尽可能好**。Shell编程其实就是将命令行的一些命令进行组装，配合shell script的一些逻辑控制实现更复杂的功能。
所以要想写出厉害的shell script，Linux基础太重要了。
基础命令如ls、cd、pwd、echo、ps等这些不用说，用户、组、文件权限(755)、设备(/dev/null)、管道命令(|)、隐藏文件权限(4755?)、服务这些都要熟悉。
Linux基础不太好的话推荐**《鸟哥的Linux私房菜 基础篇》**，前十章要看完并且动手操作一遍，整本书都能啃完自然最好。
2. **Shell script的基本语法要熟练**。鸟哥Linux私房菜第十章就是在讲Shell基础，这里面讲的东西看完，代码敲一遍，习题做完，基础就够用了。
3. **正则表达式要会灵活运用**。grep、sed、awk这些命令实在是太重要了，配合正则表达式，可以极大提高shell脚本的质量。因为shell script很多时候都是在跟字符串打交道，而正则表达式正式处理字符串的利器。
4. **最重要的还是要多写多练**。遇到问题了多Google、百度，多在命令行下面试。平时在工作过程中发现有些经常做的事情，重复性很高，都可以考虑写shell script来做自动化。
5. **深入研究shell script**。想要深入研究shell script的话，可以看看**《Linux Command Line and Shell Scripting Bible》**，中文名**《Linux命令行与shell脚本编程大全》**，这本书几乎是shell script编程的圣经，涵盖了shell script的方方面面，在亚马逊和京东上销量都很高。

## 结语

看到这里，大家会发现发现shell script其实也没那么神秘，就是将命令进行组装配合一些逻辑控制实现自动化处理。
但是要写好shell script，可不是三两天的事。
我们平时工作中发现的可以用shell script实现自动化的事情都可以尝试写写shell script，
既能提高工作效率节省时间，又能提高对UNIX-like操作系统的熟练程度，
另外写出来的脚本还可以分享给同事或者开源出去，逼格高又利人利己。
好了，我也不多说了，大家不妨开始学习，写一个简单的shell script练练手吧！
