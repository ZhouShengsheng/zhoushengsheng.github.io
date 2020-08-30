# Java集合框架

这里记录一下Java集合框架的框架图以及我在开发过程中总结一些优化策略。

## Java集合框架图

![](https://zhoushengsheng.github.io/java/image/java_collection_framework.jpg)
图片出处:《码出高效》

![](https://zhoushengsheng.github.io/java/image/java_collection_framework2.jpg)
图片出处: [Geeks for Geeks](https://www.geeksforgeeks.org/collections-in-java-2/)

## 优化策略与注意事项

这里介绍一些优化策略与使用集合的一些注意事项，部分要点会配以JDK源码。

- `Stack`继承自`Vector`，而`Vector`是线程安全的，它的很多public方法都加上了`synchronized`关键字，
因此使用`Stack`实际上也是线程安全的，因而带来了性能上的损失。推荐使用`Deque`接口的实现类代替`Stack`，
比如`ArrayDeque`、`LinkedList`。
    ```java
    public class Stack<E> extends Vector<E>
    ```
- `ArrayDeque`实现了`Deque`，如果当做堆栈使用的话，速度最快，因为入栈和出栈都在数组末尾进行。
但是要注意`ArrayDeque`不能存放`null`，但是`LinkedList`可以。
    ```java
    // ArrayDeque
    public void addLast(E e) {
        if (e == null)
            throw new NullPointerException();
        elements[tail] = e;
        if ( (tail = (tail + 1) & (elements.length - 1)) == head)
            doubleCapacity();
    }
    
    // LinkedList
    void linkLast(E e) {
        final Node<E> l = last;
        final Node<E> newNode = new Node<>(l, e, null);
        last = newNode;
        if (l == null)
            first = newNode;
        else
            l.next = newNode;
        size++;
        modCount++;
    }
    ```
- `LinkedList`的`toArray`方法首先新分配了一个同等大小的数组，然后遍历链表把元素的引用放入数组中，
所以如果改变了返回数组里面的元素的值，原始链表将会受到影响：
    ```java
    public Object[] toArray() {
        Object[] result = new Object[size];
        int i = 0;
        for (Node<E> x = first; x != null; x = x.next) {
            // 直接复制了item引用，没有深拷贝
            result[i++] = x.item;
        }
        return result;
    }
    ```
