# 简易Linux工作环境搭建

遇到过几次这样的情况，公司分配了给我一个linux服务器账号（没有root权限），但是我平时习惯了使用zsh、tmux等命令行工具，
所以每次我都会从头开始搭建一个简易的工作环境，这样我用起来比较习惯。

这篇文章主要记录以一个非root用户安装配置我常用的命令号工具的过程，内容包括：

- 预备工作
- 安装依赖库
- vim安装与配置 
- tmux安装与配置
- oh-my-zsh安装与配置


## 预备工作

1. 首先确保主机上已经安装如下软件包（一般都会安装，没有的话建议联系管理员安装）：

    - gcc (apt install build-essential)
    - git
    - python
    - python-config
    - fontconfig (apt install fontconfig)
    - wget
    - curl

2. 该文章以用户`shengsheng`为例；

3. 源码包统一放入`/home/shengsheng/3rd/src`目录中，所以先建立这个文件夹：
```bash
mkdir -p /home/shengsheng/3rd/src
```

4. 软件prefix统一为`/home/shengsheng/local`：
```bash
mkdir -p /home/shengsheng/local
```


## 安装依赖库

依赖库主要包含：

- ncurses
- libevent
- powerline
- ctags

如果系统没有上述依赖库，就需要自己编译安装。

### ncurses编译与安装

源码地址：[https://ftp.gnu.org/pub/gnu/ncurses](https://ftp.gnu.org/pub/gnu/ncurses)

下载ncurses源码：
```bash
cd ~/3rd/src
wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.1.tar.gz
tar -xf ncurses-6.1.tar.gz
cd ncurses-6.1
```

编译并安装ncurses:
```bash
# -fPIC是指定编译为动态链接库
CFLAGS="$CFLAGS -fPIC" ./configure --prefix=/home/shengsheng/local
make -j `nproc`
make install
```

### libevent编译与安装

源码地址：[https://github.com/libevent/libevent/releases](https://github.com/libevent/libevent/releases)

下载libevent源码：
```bash
cd ~/3rd/src
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar -xf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
```

编译并安装libevent:
```bash
./configure --prefix=/home/shengsheng/local
make -j `nproc`
make install
```

### 设置编译环境变量

安装完了上面两个依赖库之后，需要设置一下环境变量以便于之后其他的源码安装：
```bash
export CPATH=/home/shengsheng/local/include:${CPATH}
export LIBRARY_PATH=/home/shengsheng/local/lib:${LIBRARY_PATH}
export PATH=/home/shengsheng/local/bin:${PATH}
export LD_LIBRARY_PATH=/home/shengsheng/local/lib:${LD_LIBRARY_PATH}
```

### powerline安装

```bash
# 获取字体文件
cd ~/3rd/src
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts
mv PowerlineSymbols.otf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d

# 清空字体缓存
fc-cache -vf ~/.fonts/

# 移动字体配置文件
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```

### ctags编译与安装

源码地址：[https://sourceforge.net/projects/ctags/](https://sourceforge.net/projects/ctags/)

下载ctags源码：
```bash
cd ~/3rd/src
wget https://nchc.dl.sourceforge.net/project/ctags/ctags/5.8/ctags-5.8.tar.gz
tar -xf ctags-5.8.tar.gz
cd ctags-5.8
```

编译并安装ctags:
```bash
./configure --prefix=/home/shengsheng/local
make -j `nproc`
make install
```


## vim安装与配置

### vim编译与安装

找到最新的vim下载链接：[https://github.com/vim/vim/releases](https://github.com/vim/vim/releases)

下载vim源码：
```bash
cd ~/3rd/src
wget https://github.com/vim/vim/archive/v8.1.0606.tar.gz -O vim-8.1.0606.tar.gz
tar -xf vim-8.1.0606.tar.gz
cd vim-8.1.0606
```

编译并安装vim（参考：https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source）：
```bash
./configure --prefix=/home/shengsheng/local \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --enable-python3interp=yes \
    --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk2 \
    --enable-cscope
make -j `nproc`
make install
```

### 配置vim

安装pathgen:
```bash
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

安装vundle：
```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

复制`.vimrc`配置文件：

`.vimrc`下载链接：[.vimrc](https://github.com/ZhouShengsheng/zhoushengsheng.github.io/blob/master/linux/env/resource/.vimrc)

安装插件：
```bash
vim +PluginInstall +qall
vim -u NONE -c "helptags vim-obsession/doc" -c q
```


## tmux安装与配置

找到最新的tmux下载链接：[https://github.com/tmux/tmux/releases](https://github.com/tmux/tmux/releases)

下载tmux源码：
```bash
cd ~/3rd/src
wget https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz
tar -xf tmux-2.8.tar.gz
cd tmux-2.8
```

编译并安装tmux：
```bash
CFLAGS="$CFLAGS -I/home/shengsheng/local/include/ncurses" ./configure --prefix=/home/shengsheng/local
make -j `nproc`
make install
```

### 配置tmux

复制`~/.tmux.conf`：

`.tmux.conf`下载链接：[tmux.conf.txt](https://github.com/ZhouShengsheng/zhoushengsheng.github.io/blob/master/linux/env/resource/.tmux.conf)

安装tmux插件管理器`tpm`:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```


## oh-my-zsh安装与配置

### zsh编译与安装

如果系统已经有zsh了，那么可以跳过这一步骤，直接用系统提供的zsh，如果没有的话就需要从源码编译安装。

到zsh源码官网上找到最新的源码：[http://zsh.sourceforge.net/Arc/source.html](http://zsh.sourceforge.net/Arc/source.html)

下载zsh源码：
```bash
cd ~/3rd/src
wget https://sourceforge.net/projects/zsh/files/zsh/5.6.2/zsh-5.6.2.tar.xz/download -O zsh-5.6.2.tar.xz
tar -xf zsh-5.6.2.tar.xz
cd zsh-5.6.2
```

编译并安装zsh:
```bash
./configure --prefix=/home/shengsheng/local
make -j `nproc`
make install
```

配置zsh：

将下面的这些配置复制到`~/.bashrc`末尾，配置zsh为默认shell：
```bash
# Setup zsh
ZSH_HOME=${HOME}/local
export PATH=${ZSH_HOME}/bin:${PATH}
[ -f ${ZSH_HOME}/bin/zsh ] && exec ${ZSH_HOME}/bin/zsh -l
```

然后source一下`~/.bashrc`：
```bash
source ~/.bashrc
```

会出来一个zsh的设置菜单，输入0会生成一个~/.zshrc配置文件。

到这里，zsh已经安装完毕了，并且以后每次启动shell，默认会使用zsh。

### 安装oh-my-zsh

oh-my-zsh官网：https://github.com/robbyrussell/oh-my-zsh

使用官方提供的脚本安装：
```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

打开`~/.zshrc`，修改`ZSH_THEME`设设置主题：
```bash
ZSH_THEME="refined"
```

再将刚才的环境变量设置命令复制到`~/.zshrc`中：
```bash
export CPATH=/home/shengsheng/local/include:${CPATH}
export LIBRARY_PATH=/home/shengsheng/local/lib:${LIBRARY_PATH}
export PATH=/home/shengsheng/local/bin:${PATH}
export LD_LIBRARY_PATH=/home/shengsheng/local/lib:${LD_LIBRARY_PATH}
```

source一下`~/.zshrc`使oh-my-zsh生效：
```bash
source ~/.zshrc
```

### 安装oh-my-zsh常用插件

常用插件包括：

- autosuggestions
- syntax-highlighting
- autojump
- tmux

安装插件：

```bash
# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# autojump
cd ~/3rd/src
git clone git://github.com/joelthelion/autojump.git
cd autojump
./install.py -d /home/shengsheng/.autojump
# 将下面的autojump配置复制到~/.zshrc末尾
[[ -s /home/shengsheng/.autojump/etc/profile.d/autojump.sh ]] && source /home/shengsheng/.autojump/etc/profile.d/autojump.sh
```

编辑`~/.zshrc`，将plugins修改为：
```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
  tmux
)
```

source一下`~/.zshrc`：
```bash
source ~/.zshrc
```


## 总结

至此，简单的linux工作环境（vim、tmux、oh-my-zsh）就搭建好了。
由于软件一直在更新，在搭建过程中可能会出现一些问题，比如配置文件某些项不能用，所以要视具体情况做一些简单的修改。
