# JVM

这里记录一下JVM（Java虚拟机）的一些基本概念。

## JVM运行时数据区域

<center><img src="https://zhoushengsheng.github.io/java/image/jvm_data_area.svg" alt="JVM Runtime Data Area" width="480"></center>

## JVM调优常用参数

### GC调试

* `-verbose:gc`: 打印GC跟踪日志；
* `-XX:+printGC`: 打印GC的简要日志；
* `-XX:+PrintGCDetails`: 打印GC的详细日志；
* `-XX:+PrintGCTimeStamps`: 打印GC发生的时间戳；
* `-Xloggc:gc.log`: 将GC的日志输出到gc.log文件；
* `-XX:+PrintHeapAtGC`: 每次GC前后都打印堆的信息。

### 内存设置

* `-Xms`: 初始堆空间大小(e.g.: -Xms256m)；
* `-Xmx`: 最大堆空间大小(e.g.: -Xmx2g)；
* `-Xmn`: 新生代空间大小；
* `-Xss`: JVM栈空间大小；
* `-XX:NewRatio`: 新生代和老年代的大小比例；
* `-XX:SurvivorRatio`: 两个Survivor总的空间与新生代空间的比值；
* `-XX:PretenureSizeThreshold`: 大于此值的对象直接在老年代进行分配；
* `-XX:MaxTenuringThreshold`: 指定年龄阈值，年龄大于此值时进入老年代。

## 参考资料

* [周志明 深入理解Java虚拟机：JVM高级特性与最佳实践](https://item.jd.com/11252778.html)
* [CS-Notes Java虚拟机](https://github.com/CyC2018/CS-Notes/blob/master/notes/Java%20%E8%99%9A%E6%8B%9F%E6%9C%BA.md)
* [JDK1.8之前和之后的方法区](https://blog.csdn.net/qq_41872909/article/details/87903370)
* [JDK1.8 JVM运行时数据区域划分](https://blog.csdn.net/bruce128/article/details/79357870)
* [常用的JVM配置参数](https://www.cnblogs.com/wuyx/p/9627542.html)
