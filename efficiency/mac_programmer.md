# 程序员如何优雅地使用MacOS

这篇文章是我在知乎下的一个[回答](https://www.zhihu.com/question/20873070/answer/189101629)，
我现在把这篇文章搬到我的博客，将来的更新也会同步到知乎回答。

作为程序员，那么就应该追求工作效率，不得不说，Mac确实是提高工作效率的神器。这篇文章结构如下:

*   **基础篇** - 优雅必备的基本功
*   **工具篇** - 一大波提高生产力的工具推荐
*   **高级篇** - 自定义.bash_profile，写shell script，效率再上一层楼

## **基础篇**

工欲善其事，必先利其器，我们程序员要想优雅的使用MacOS，就得先把最基本的技能练好。

### 1. 盲打

是的，你没看错，就是盲打！既然大家都是程序员，那么毫无疑问，我们键盘敲得最对。如果不会盲打，就得经常看键盘，比起盲打是不是浪费了一些移动脖子、找按键的时间。如果还不会盲打，那么赶紧开始练吧，我在大一刚入学时，坚持了一个月的盲打练习，后来再也不需要找按键了(f1-12例外)。推荐两款软件练习:

**(1) [金山打字通](https://www.51dzt.com/)**

如果你的Mac装了Windows，或者Windows虚拟机，那么十分推荐用金山打字通来练习，我当时就是用这个软件来练习的。

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/jinshan.png" width="480"></center>

**(2) [Typing Club](https://www.typingclub.com/)**

这个软件是网页版，我体验了一下，也挺不错的，循序渐进带你练打字。不过Typing Club是全英文的，但是作为程序员，这点英文应该不是难事。

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/typeclub.jpg" width="480"></center>

### 2. 精通快捷键

Mac OS提供的系统级别的快捷键还是要十分熟练的，这些几乎在任何应用中都有效，所以务必掌握。符号说明: ⌘ - command，⌃ - control，⇧ - shift，⌥ - option，⌫ - delete。常用的快捷键列举如下:

*   **⌘ + c, v, x, z, a**: 复制、粘贴、剪切、撤销、全选
*   **⌘ + b, u, i**: 变粗体、加下划线、变斜体
*   **⌃⌘ + f**: 进入全屏模式
*   **⌘ + n, t**: 新建窗口、新建Tab
*   **⌘ + w, h, q**: 关闭窗口、隐藏程序、退出程序
*   **⌘ + ←, →**: 跳转至行首部、跳转至行尾
*   **⌘ +** ⌫: 删除至行首
*   ⌥ **+ ←, →**: 左跳一个单词、右跳一个单词
*   ⌥ **+** ⌫: 删除一个单词
*   **⌘(按住) + tab**: 切换程序
*   **⌘ + o, ↑, ↓**: (Finder中使用)打开文件、上级目录、下级目录
*   **⇧⌘ g**: (Finder中使用)前往路径
*   **鼠标双击**: 选中单词
*   **鼠标双击后拖动**: 选中连续单词(特别好用，你会爱上它:))
*   **鼠标三击**: 选中一行
*   **鼠标三击后拖动**: 选中连续多行

### 3. 掌握触摸板

我其实鼠标用的比较多，因为鼠标比触摸板要快得多。尽管如此，我还是经常用到触摸板，比如显示所有全屏程序、显示Launchpad。有时候出门带上Mac，不方便带鼠标，那么触摸板就更派上用场了。所以触摸板的一些快捷方式还是有必要掌握的:

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/trackpad.png" width="720"></center>

上图加红框的快捷操作，是我平时用的比较多的，它们分别是:

*   **双指单击**: 显示菜单(就是鼠标右击)
*   **单指单击**: 选择(就是鼠标左击，注意这一项默认没有开启)
*   **双指拖动**: 滚动
*   **四指左右拖动**: 切换全屏程序(新版的Mac好像默认是三指拖动)
*   **四指收缩**: 显示Launchpad(方便找程序，下文会介绍更方便的找程序的方法)

### 4. 使用全屏程序

这个实在是太好用了，这也是我不喜欢用Windows和Linux的一个重要原因。全屏程序就是将一个程序全屏化，就像打游戏一样，你看不见任何其他程序甚至顶部状态栏和底部菜单栏，我觉得**全屏程序的最大优点在于它可以让用户专注于一个程序**。比如我做开发的时候，那么眼前除了全屏化的IntelliJ，没有任何别的程序干扰，我可以专注的写代码。另外，**全屏程序可以程序间的切换变得容易**，打开全屏程序列表，然后选中就可以了，或者使用触摸板手势左右切换全屏程序。使用快捷键(**⌃⌘ + f**)就可以快速进入全屏程序，你也可以点击窗口左上角的绿色按钮进入。再全屏模式使用快捷键或者点绿色按钮就可以退出全屏模式。

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/full_screen.png" width="720"></center>


## **工具篇**

这里推荐一些好用的工具，可以大大提高我们开发和日常工作的效率。

### 1. Homebrew

* **简介**：这个大家一定不陌生，这几乎是Mac上安装命令行程序最好的工具，类似于Ubuntu上的apt-get或CentOS上的yum。虽然大家对它很熟悉，不过小编还是把它放在了回答里面，要是你还没装的，赶紧点击链接下载安装吧。
* **链接**：https://brew.sh/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/homebrew.jpg" width="480"></center>

### 2. iTerm2 + oh-my-zsh

* **简介**：iTerm比Mac自带的Terminal要好用，因为iTerm支持子窗口、自动补全、Shell Integration等许多好用的功能，详细的功能列表可以来这里查看: [Features - iTerm2 - macOS Terminal Replacement](https://www.iterm2.com/features.html)。zsh比bash要好用，具备更强的提示功能，提供共享历史记录，oh-my-zsh是对zsh的一个个性化定制，提供了更多强大的功能和好看的主题。
* **链接**：https://www.xplatform.rocks/2015/05/07/setting-up-iterm2-with-oh-my-zsh-and-powerline-on-osx/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/zsh.png" width="720"></center>

### 3. Vim

* **简介**：这可能是史上最好用的命令行文本编辑器了，推荐大家在命令行下编辑文件比如修改配置时，使用Vim来处理。此外，Vim不光可以用在命令行下编辑文版，Vim也有Mac的桌面版MacVim，可以直接编辑窗口中的文件。而且，许多IDE也以插件的形式整合了Vim，比如IntelliJ、AppCode、Eclipse、Android Studio等，小编在做Java开发和iOS开发的时候，已经无法离开Vim...说到IDE，其实Vim也是一款不折不扣的IDE，而且在所有IDE中排名第四，有图有真相(17年6月的统计数据，链接: [TOP IDE Top Integrated Development Environment index](https://pypl.github.io/IDE.html)):
* **链接**：https://www.vim.org/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/ide.png" width="480"></center>

最后考考大家下面这一串Vim指令做了什么操作(⎋是esc键)，Vim高手请忽略:

```
⎋qa$r!⎋jq9@a
```

### 4. Tmux

* **简介**：C语言写的命令行里面多窗口、子窗口的神器，服务器上跑程序再也不用保持连接了，直接开个tmux session就好了，下回登陆服务器继续之前的session接着干活。还可以自己写tmux脚本自定义workspace，服务器上面这个功能简直太实用了！推荐书籍：Tmux 2: Productive Mouse-Free Development (好像只有英文版)
* **链接**：https://github.com/tmux/tmux

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/tmux.png" width="720"></center>

### 5. Shuttle

* **简介**：Shuttle可以说是一款快捷操作管理软件，我们可以把一些经常的登录服务器命令添加到Shuttle里面，以后只要在Shuttle里面选择那一项，那么Shuttle就会帮我们在终端里面运行定义好的命令，完成预期操作。凡是可以在命令行下写出来的命令，我们都可以放在Shuttle里面，因为Shuttle就是在我们选择某一项的时候，打开终端或者在已有终端中，运行我们定义的命令。
* **链接**：https://fitztrev.github.io/shuttle/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/shuttle.jpg" width="480"></center>

### 6. Go2Shell

* **简介**：这是一款十分小巧的Finder插件，在Finder中，我们只要点击Go2Shell按钮，Go2Shell就会帮我们在命令行中打开当前目录。
* **链接**：https://itunes.apple.com/cn/app/go2shell/id445770608%3Fl%3Den%26mt%3D12

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/gotoshell.png" width="480"></center>

### 7. SourceTree

* **简介**：一款免费的版本控制软件，不喜欢用命令行或者Shell Script的可以用这款软件。这款软件提供了几乎所有Git的操作，配合软件提供的快捷键，可以方便、高效的完成对Git仓库的管理。还有一款朋友推荐的版本控制软件叫[Tower](https://www.git-tower.com/mac/)，据说是最好用的版本控制软件，就是有点贵(79美金)，我试用了一下感觉还不错，可能我用惯了SourceTree，所以对Tower没什么感觉。
* **链接**：https://www.sourcetreeapp.com/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/sourcetree.png" width="720"></center>

### 8. Paste

* **简介**：可能是最好用的复制粘贴软件，Paste会记录我们比较久的复制记录，不像默认的剪切板只有一条记录，另外Paste提供了对复制记录的管理，比如我们可以新建Tab然后把一些常用的操作(比如连接Redis、Redis授权)保存下来，用到的时候直接调出Paste窗口然后选择粘贴就好。
* **链接**：https://pasteapp.me/
* **价格**：9.9 USD

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/paste.png" width="480"></center>

### 9. Postman

* **简介**：免费而强大的HTTP调试工具，不管是做前端、后端还是移动端，只要是要跟API打交道，都要用一款HTTP调试工具来检测API，那么这款软件就非常适合。Postman还支持API分组、宏定义、API参数注释、API分组分享等许多实用的功能，都是开发过程中经常用到的。
* **链接**：https://www.getpostman.com/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/postman.png" width="720"></center>

### 10. Alfred

* **简介**：Alfred的口号就是高效，我用它来做的最多的就是搜索，在任何地方用快捷键调出Alfred搜索栏，然后输入搜索内容就可以搜索，搜索既可以是App、文件，也可以直接选择在Google中搜索。这款软件可以免费使用，不过许多功能都要付费才能用，它所提供的所有功能在首页里面都有介绍，大家可以点连接去首页看看。
* **链接**：https://www.alfredapp.com/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/alfred.png" width="720"></center>

### 11. Reminder

* **简介**：为什么这个App没链接呢，因为它就是Mac自带的备忘录。把要做的事情写在Reminder里面并且设置提醒时间，那么到时候就会收到提醒通知。更强大的To-Do List软件推荐[Todoist](https://en.todoist.com/mac)，这款App提供了更加完善的To-Do List功能，可以设置复杂的提醒逻辑(比如每月最后一天提醒)。对我来说，Reminder足够了，虽然Todoist我也装了，不过用的并不多。

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/reminder.png" width="480"></center>

### 12. Sequel Pro

* **简介**：一款数据库客户端软件，虽然没有Navicat那么强大，但这款软件开源、免费，一般的数据库操作如建库建表、备份这款软件都支持，所以基本可以在开发中拿来作为数据库客户端。
* **链接**：https://www.sequelpro.com/

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/sequel_pro.png" width="720"></center>

### 13. Charles

* **简介**：神级抓包工具，自己本身也可以作为代理，在手机上设置代理之后可以用来抓手机上的包，在开发API或者对接API时非常有用。就是稍微贵了点，一个license要50美刀。
* **链接**：https://www.charlesproxy.com/
* **价格**：50 USD

<center><img src="https://zhoushengsheng.github.io/efficiency/image/mac_programmer/charles.jpg" width="720"></center>

## **高级篇**

在高级篇里面，小编主要介绍**如何通过自定义shell和写shell script来进一步提高工作效率**。我们在工作过程中，经常会遇到一些十分重复的工作，比如cd到某一个项目目录、在工程划分比较细的项目里经常要对每个工程进行git pull，**凡是这些重复的、有规律可循的工作，我们都可以通过自定义shell或者写shell script来简化工作流程，提高效率**。

### 1. 自定义shell

这里所说的自定义shell其实就是个性化配置.bash_profile(或者.bashrc甚至自己写的一些rc(run commands)文件)。**我比较习惯写一个独立的rc文件，然后在.bash_profile里面source它。**我把所有跟公司相关的个性化配置全部写在.cws_rc里面，并且放在与公司相关的文件夹根目录，然后在~/.bash_profile中source那个.cws_rc。

下面贴出.cws_rc代码和.bash_profile的部分代码:

> .cws_rc

```bash
# Cloud Wings run commands.
# Author: Shengsheng
# Date: 22/05/17

#=============================
# Environment
#=============================

export CWS_HOME="/path/to/cws-home"
export CWS_WORKSPACE="${CWS_HOME}/Workspace"
export CWS_RC="${CWS_HOME}/.cwsrc"

#=============================
# Common
#=============================

colorBlack="`    tput setaf 0; tput bold`"
colorRed="`      tput setaf 1; tput bold`"
colorGreen="`    tput setaf 2; tput bold`"
colorYellow="`   tput setaf 3; tput bold`"
colorBlue="`     tput setaf 4; tput bold`"
colorMagenta="`  tput setaf 5; tput bold`"
colorCyan="`     tput setaf 6; tput bold`"
colorWhite="`    tput setaf 7; tput bold`"
colorUnderline="`tput sgr 0 1`"
#colorOff="`      tput sgr0`"
colorOff="`     echo -ne "^[[m\x0f"`"

#=============================
# Rc
#=============================

# print run commands info for cws
function cwsRcInfo() {
    echo "CWS_HOME:      ${CWS_HOME}"
    echo "CWS_WORKSPACE: ${CWS_WORKSPACE}"
    echo "CWS_RC:        ${CWS_RC}"
}

alias cws_rc_info="cwsRcInfo"
alias cws_rc_edit="vim ${CWS_RC}"

#=============================
# Cd
#=============================

alias cws_cd="cd ${CWS_WORKSPACE}"
alias cws_cd_oss="cd ${CWS_WORKSPACE}/OSS"
alias cws_cd_sdk="cd ${CWS_WORKSPACE}/SDK"
alias cws_cd_res="cd ${CWS_HOME}/Resource"

#=============================
# Server
#=============================
alias cws_server_dev_node1="ssh cws@192.168.1.2"
alias cws_server_beta_node1="ssh cws@192.168.1.3"
alias cws_server_mgt_node1="ssh cws@192.168.1.4"
alias cws_server_mgt_node2="ssh cws@192.168.1.5"
alias cws_server_prod_node1="ssh cws@192.168.1.6"
alias cws_server_prod_node2="ssh cws@192.168.1.7"
alias cws_server_prod_node3="ssh cws@192.168.1.9"

#=============================
# Software
#=============================

alias cws_redis_dev="redis-cli -h 192.168.1.2 -a 123456"

#=============================
# Util
#=============================

# open verification code image url in chrome
function openVerificationUrl() {
    imageUrl=$1
    # copy image url to clipboard
    #echo -n "${imageUrl}" | pbcopy
    # open in chrome
    open /Applications/Google\ Chrome.app "${imageUrl}"
    echo "${imageUrl}"
}
alias cws_util_verification_url="openVerificationUrl "

```

> .bash_profile

```bash
# cws run commands
CWS_RC="/path/to/cws-home/.cwsrc"
if [ -f "${CWS_RC}" ]; then
        . ${CWS_RC}
fi

```

以上的自定义shell是我在工作中真正用的，只是改了一些路径和服务器地址，因为不方便在知乎里面贴出来。可以看出，**我在.cws_rc中写了大量的alias，用于给命令取别名**，比如我运行cws_server_dev_node1，那么实际就会执行ssh 192.168.1.2，这个比起你直接输入ssh命令要好记多了。而且**写在.cws_rc里面的命令，都支持shell自带的命令补全**，我们只要记得命令规则长啥样，就算忘了命令，也能通过shell来补全。在.cws_rc中我另外还写了一些函数，方便做一些逻辑上的处理。

不难发现，**通过自定义shell，我们可以大量简化一些常用的命令行操作**，这对运维人员和后端开发人员尤其有用，当然做Web开发或者移动开发也可以从自定义shell中受益。

### 2. Shell Script

关于shell script，我单独写了一篇博客: [Shell Script - 提高工作效率的必备神器](https://zhoushengsheng.github.io/#/efficiency/shell_script)，详细介绍了如何用shell script来提高工作效率以及怎么学习shell script。我只把文章的目录搬过来:

*   引言
*   Shell Script简介
*   Shell Script实际应用
*   如何学习Shell Script
*   结语

关于shell script我就不再说什么了，如果感兴趣的话，点击链接看我的文章就好。

## **结语**

要想优雅地使用MacOS，首先是基本功，基本功打好了就是挑武器，也就是那些工具，最后是更深一层次的自定义shell和写shell script。我也在不停的尝试新的软件、学习新的技能来不断提高工作效率，这篇文章将会一直更新下去，我会跟大家一起努力，创造高效的Mac工作环境。
