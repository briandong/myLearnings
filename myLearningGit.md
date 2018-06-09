[TOC]

# My Learning Git

## 参考资料

廖雪峰的git教程：

https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000

特别是里面关于git诞生的有趣历史：

https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137402760310626208b4f695940a49e5348b689d095fc000

## git基础

### 安装

#### website

官网：https://git-scm.com/downloads

#### linux

更新PPA源，在Ubuntu里安装最新版本Git
```
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```
#### windows

直接官网下载安装可执行文件

### config

用户设置
```
git config --global user.name "John Smith"
git config --global user.email jsmith@example.com
```

文本编辑器
```
git config --global core.editor gvim
git config --global merge.tool gvimdiff
```

让Git以彩色显示
```
git config --global color.ui auto
```

设定别名
```
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```

查看配置信息

```
git config --list
```

### .gitignore 

忽略某些文件时，需要编写.gitignore。

不需要从头写.gitignore文件，GitHub已经为我们准备了各种配置文件，只需要组合一下就可以使用了：https://github.com/github/gitignore

### 获取帮助

```
git help <verb>
git <verb> --help
man git-<verb>
```

## 使用git

### 基本流程
```c
Untracked  Unmodified(repo)  Modified(unstaged)  Staged
   |-----------------------add--------------------->|
                |<--------------commit--------------|
                |--------edit-------->|-----add---->|
                |<----checkout -- ----|<---reset----|
                |<--------reset --hard HEAD---------|
   |<----rm-----|
```
### init

把当前目录设置到Git数据库
```
git init
```

### status

确认工作树和索引的状态
- -s，显示简化版本状态

```
git status [-s]
```

### add

将文件加入到索引，指定加入索引的文件，用空格分割可以指定多个文件
```
git add <file> ...
```

可以把所有的文件加入到索引
```
git add .
```

### rm

将文件移出索引，变成untracked状态
```
git rm <file> ...
```

### diff
显示文件变化
- HEAD，显示staged和unstaged变化
- --cached，只显示staged变化
- 都不加，只显示unstaged变化

```
git diff [HEAD] [--cached] <file> ...
```

### commit

提交文件
- -a，自动'git add'
- --amend，追加到上次的commit
- --no-edit，不改变comment
```
git commit [-a] [-m "<comment>"] [--amend] [--no-edit]
```

### log

查看数据库的提交记录。
- --graph，以文本形式显示更新记录的流程图
- --oneline，在一行中显示提交的信息
- -n，显示最近的n次commit
```
git log [--graph] [--oneline] [-n]
```

### reflog

查看数据库的全部历史记录，包括被回退的版本
```
git reflog
```

### reset

reset用于版本回退。

从staged状态reset回unstaged状态
```
git reset HEAD <file>
```

从staged状态reset回HEAD（HEAD表示当前版本，也就是最新的提交版本 ）

```
git reset --hard HEAD
```

移动HEAD到更早的commit
```
git reset --hard HEAD^ (HEAD的前一个commit)
git reset --hard HEAD^^ (HEAD的前两个commit)
git reset --hard HEAD~3 (HEAD的前三个commit)
```

或直接使用'git reflog'里的ID
```
git reset --hard <ID>
or
git reset --hard HEAD@{0}
```

### checkout

撤销文件修改(checkout --)。checkout其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”
```
git checkout -- <file>
```

切换branch
```
git checkout <branch>
```

### stash
stash功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作。

建立一个暂存的文件空间
```
git stash
```
列出stash

```
git stash list
```

恢复修改

```
git stash pop
```

## branch

分支branch是为了将修改记录的整体流程分叉保存。分叉后的分支不受其他分支的影响，所以在同一个数据库里可以同时进行多个修改。
分叉的分支可以合并。

### 建立branch

新建branch
```
git branch <branch>
```



新建branch并切换

```
git checkout -b <branch>
```

就相当于以下两条指令：

```
git branch <branch>
git checkout <branch>
```



查看所有branch

```
git branch
```

### 切换branch
切换branch
- -b，新建branch
```
git checkout [-b] <branch>
```

### merge branch
合并branch到master
- --no-ff -m "<comment>"，no fast forward并加入comment
  通常合并分支时，如果可能，Git会用Fast forward模式，但这种模式下删除分支后，会丢掉分支信息
  禁用Fast forward模式，Git就会在merge时生成一个新的commit，这样，从分支历史上就可以看出分支信息
```
git checkout master
git merge [--no-ff -m "<comment>"] <branch>
```

如果出现conflict，需要修复
```
<<<<<<< HEAD
master
=======
<branch>
>>>>>>>
```
之间的冲突部分内容，然后再commit就可以了

### rebase
顾名思义，就是重新设定branch的基础
```
git rebase <branch>
```

如果可能出现conflict，需要修复，然后
```
git rebase --continue/skip/abort
```

* rebase操作可以把本地未push的分叉提交历史整理成直线；
* rebase的目的是使得我们在查看历史提交的变化时更容易，因为分叉的提交需要三方对比

### 删除branch

删除branch
```
git branch -d <branch>
```
丢弃一个没有被合并过的分支
```
git branch -D <branch>
```

## 远程数据库

### 添加远程数据库
使用remote指令添加远程数据库，使用push命令向数据库推送更改内容。

从全新repository开始：
```
echo "# testit" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/briandong/testit.git
git push -u origin master
```

由已有repository开始：
```
cd existing-project
git remote add origin https://github.com/briandong/testit.git
git push -u origin master
```

更改已有的远程数据库：

```
git remote set-url origin <url>
```

*注意：第一次push master分支时，加上-u参数会把本地的master分支和远程的master分支关联起来，在以后的push时就可以简化命令不需要-u参数了*

### 克隆远程数据库

使用clone指令可以复制数据库
```
git clone https://github.com/briandong/testit.git
```

### 从远程数据库pull
使用pull指令进行拉取操作。省略数据库名称的话，会在名为origin的数据库进行pull
```
git pull
```

### 合并修改记录
<<<<<<< HEAD 与 >>>>>>> 之间是冲突部分。

==分割线上方是本地数据库的内容, 下方是远程数据库的编辑内容。

### 远程branch

查看远程分支：
```
$ git branch -r
```

本地创建和远程分支关联的分支：
```
$ git checkout -b dev origin/dev
```

如果需要，建立本地分支和远程分支的关联:
```
git branch --set-upstream branch-name origin/branch-name
```

提交本地分支作为远程分支:
```
$ git push origin test:test
```

删除远程分支:
```
$ git push origin :test
```

## Tag

注意：标签总是和某个commit挂钩。如果这个commit既出现在master分支，又出现在dev分支，那么在这两个分支上都可以看到这个标签

### 新建tag

```
git tag v1.0
```

### 在指定commit ID上新建tag

```
git tag v0.9 f52c633
```

### 新建带有说明的tag

```
git tag -a v0.1 -m "version 0.1 released" 1094adb
```

### 查看tag信息

```
git show v0.9
```

### 查看所有tag

```
git tag
```

### 删除tag信息

```
git tag -d v0.1
```

 ### 推送tag到远程数据库

```
git push origin v1.0
```

### 推送所有tag到远程数据库

```
git push origin --tags
```

### 删除远程数据库tag 

需要先删本地tag，再删除远程tag

```
git tag -d v0.9
git push origin :refs/tags/v0.9
```



## Github

首先要生成密钥
```
ssh-keygen -t rsa -C "abc@def.com“
```

从生成的～/.ssh/id_rsa.pub文件复制密匙，然后到github网站登录自己的账号，在settings->SSH Keys添加新密匙

检验是否链接上了github
```
ssh git@github.com
```

在github网站新建repository，开始推送
```
git remote add origin git@github.com:infinityblade/vim.git
git push -u origin master
```

下载你的项目
```
git clone https://github.com/infinityblade/vim.git .
git submodule update --init --recursive
```

## Tips

### git GUI

```
gitk
```

### 403 Forbidden when 'git push'
Symptom:
> $ git push                   
error: The requested URL returned error: 403 Forbidden while accessing https://github.com/briandong/uvmGen.git/info/refs                                            
fatal: HTTP request failed

Solution: 
1. open .git/config
1. in [remote "origin"], update url field as "url = https://briandong@github.com/briandong/uvmGen.git"
1. 'git push' again

### Cannot access external web services
Symptom:
> connect to host github.com port 22: Connection timed out

> fatal: The remote end hung up unexpectedly

Solution: 
Set git proxy:
```
git config --global http.proxy http://nww.nics.nxp.com:8080/proxy.pac
git config --global https.proxy http://nww.nics.nxp.com:8080/proxy.pac
```
