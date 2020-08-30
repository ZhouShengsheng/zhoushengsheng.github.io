# git常用命令

克隆项目并指定目标文件夹：
```bash
git clone https://git_url folder_name

# 例如，将zsh源码克隆到zsh文件夹：
git clone git://git.code.sf.net/p/zsh/code zsh
```

新建本地分支：
```bash
git checkout -b branch_name
```

将本地新建的分支推到远程：
```bash
git push -u origin branch_name
```

撤销所有本地当前的修改：
```bash
git reset --hard
```

取消当前的提交（还没有push到远程）：
```bash
git reset HEAD~
```

打tag：
```bash
# tag_name一般为版本号，如：1.0.0
git tag tag_name
```

将tag推向远程：
```bash
git push --tags
```

Untrack文件：
```bash
# 1. 将文件添加至.gitignore中
# 2. 提交所有更改
# 3. 清空仓库
git rm -r --cached .
# 4. 添加所有文件
git add .
# 5. 提交
git commit -m "Fixed"
```
