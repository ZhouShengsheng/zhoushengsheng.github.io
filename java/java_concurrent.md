# Java并发

这里记录一下Java多线程的一些基本概念、JUC(java.util.concurrent)下面各个模块、UML以及推荐阅读。图片均为矢量图，如果不够清晰的话可以放大来看。

## Java线程状态

<center><img src="https://zhoushengsheng.github.io/java/image/java_thread_states.svg" alt="Java thread states" width="420"></center>
<center>图片参考: Core Java Vol 1, 9th Edition, Horstmann, Cay S. & Cornell, Gary_2013</center>

Java线程主要有以下几种状态：
- **New**: 刚创建线程，还没有调用`.start()`方法，则进入**新建状态**；
- **Runnable**: 线程调用`.start()`方法进入**可运行状态**，正在执行或者等待获取cpu时间片都算Runnable状态；
- **Blocked**: (1) 当线程尝试进入临界区时，但是另外的线程持有改锁，则进入**阻塞状态**；(2) 或者该线程已经在临界区，
但是调用了`Object.wait()`方法(此时线程会释放锁，进入Waiting或Timed Waiting状态)，
当`wait()`返回时该线程需要重新进入临界区时(需要重新获取锁)，也会进入阻塞状态；
- **Waiting**: 当线程调用`Object.wait()`、`Thread.join()`或`LockSupport.park()`方法，
线程会进入**等待状态**；
- **Timed Waiting**: 当线程调用`Thread.sleep`、`Object.wait with timeout`、`Thread.join with timeout`、`LockSupport.parkNanos`或`LockSupport.parkUntil`带有时间选项的这些函数时，
则进入**定时等待状态**；
- **Terminated**: 线程执行完毕正常退出，或者线程执行过程中异常退出，都会进入**终止状态**。

## Java线程数优化

Java最大线程数可由以下公式计算:
```
maxThreadCount = (maxProcessMemory - JVMMemory - reversedOSMemory) / threadStackSize 
```

- `maxProcessMemory`: 指的是操作系统下一个进程最大可用内存，Linux下可通过修改`vm.max_map_count`参数来调节，对应文件位于`/proc/sys/vm/max_map_count`。
`vm.max_map_count`是进程最大可拥有的VMA(虚拟内存区域)的数量，默认值为65536，
在64位操作系统下内存地址是64位，65536 * 64 / 1024 / 1024 = 4G，也就是进程默认可以申请4G的内存；
- `JVMMemory`: 分配给JVM的内存，通过-Xms和-Xmx指定；
- `reversedOSMemory`: 操作系统的保留内存；
- `threadStackSize`: JVM堆栈大小，通过-Xss指定。

通过调节`maxProcessMemory`、`JVMMemory`、`threadStackSize`可以调节JVM最大线程数，基本上分配给JVM的内存越少、线程栈越小，可创建的线程越多。
因为创建一个Java线程，同时还是会创建一个操作系统级别的线程(如Linux下的pthread)，而操作系统线程不在JVM内存中创建。

### 参考资料

- [JVM中可生成的最大Thread数量](https://jzhihui.iteye.com/blog/1271122)
- [Jvm支持的最大线程数](https://www.cnblogs.com/zhangshiwen/p/5793908.html)
- [linux参数之max_map_count](https://www.cnblogs.com/duanxz/p/3567068.html)

## Executor

Executor相关类是JDK提供我们开发多线程程序的利器，线程池大大简化了我们开发与管理多线程。

### Executor UML

<center><img src="https://zhoushengsheng.github.io/java/image/java_executor_uml.svg" alt="Java Executor UML" width="720"></center>

### 推荐阅读

* [Java Executor并发框架（一）整体介绍](https://www.cnblogs.com/vhua/p/5277694.html)

## AQS

JUC提供了各种比synchronized更强、更灵活的锁实现，其中AQS(AbstractQueuedSynchronizer)是这些锁实现的核心。

### AQS UML

<center><img src="https://zhoushengsheng.github.io/java/image/java_aqs_uml.svg" alt="Java AQS UML" width="720"></center>

### 推荐阅读

* [Java 并发之AbstractQueuedSynchronizer(AQS)操作图解细节](https://www.jianshu.com/p/282bdb57e343)
* [Java并发编程之ReentrantLock详解](https://blog.csdn.net/qq_38293564/article/details/80515718)
* [Java 并发之CountDownLatch 计数器 操作图解细节](https://www.jianshu.com/p/fb454a523a0f)
* [深入理解CyclicBarrier原理](https://blog.csdn.net/qq_39241239/article/details/87030142)
