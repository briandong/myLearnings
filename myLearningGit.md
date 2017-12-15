[toc]

# My Learning Git

## git基础

### 安装

#### website

https://git-scm.com/downloads

#### linux

更新PPA源，在Ubuntu里安装最新版本Git
```
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
```
#### windows

直接下载安装可执行文件

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
git config --global alias.co checkout
git config --global alias.st status
```

查看配置信息

```
git config --list
```

### 获取帮助
```
git help <verb>
git <verb> --help
man git-<verb>
```

## 使用git

### 基本流程
```c
Untracked  Unmodified(repo)  Modified  Staged
   |------------------add---------------->|
                |<---------commit---------|
                |-----edit----->|---add-->|
                                |<-reset--|
                |<---reset --hard HEAD----|
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
```
git log [--graph] [--oneline]
```

### reflog

查看数据库的全部记录
```
git reflog
```

### reset

从staged状态reset回unstaged状态
```
git reset <file>
```

从staged状态reset回HEAD
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

回退文件到过去的版本
```
git checkout <ID> -- <file>
```

切换branch
```
git checkout <branch>
```

### stash
建立一个暂存的文件空间
```
git stash
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
- --no-ff -m "<comment>"，no fast forward加入comment
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

### 删除branch
删除branch
```
git branch -d <branch>
```

## 远程数据库
### push到远程数据库
使用remote指令添加远程数据库。在name处输入远程数据库别名，在url处指定远程数据库的URL。

如果code全新，未由git管理：
```
git init
git add --all
git commit -m "<comment>"
git remote add <name> <url>
```
*Tips*:
如果省略了远程数据库的名称，则默认使用名为”origin“的远程数据库

例如：
```
git remote add origin ssh://git@sw-stash.freescale.net/~nxf06757/vim.config.git
```

如果code已经由git管理：
```
cd existing-project
git remote set-url origin ssh://git@sw-stash.freescale.net/~nxf06757/vim.config.git
```

使用push命令向数据库推送更改内容，repository处输入目标地址，refspec处指定推送的分支
```
git push <repository> <refspec> ...
```
运行以下命令便可向远程数据库‘origin’进行推送。当执行命令时，如果指定了-u选项，那么下一次推送时就可以省略分支名称了。但是，首次运行指令向空的远程数据库推送时，必须指定远程数据库名称和分支名称
```
git push -u origin master
```

### 克隆远程数据库
使用clone指令可以复制数据库，在repository指定远程数据库的URL，在directory指定新目录的名称
```
git clone <repository> <directory>
```

### 从远程数据库pull
使用pull指令进行拉取操作。省略数据库名称的话，会在名为origin的数据库进行pull
```
git pull <repository> <refspec> ...
```

### 合并修改记录
<<<<<<< HEAD 与 >>>>>>> 之间是冲突部分。

==分割线上方是本地数据库的内容, 下方是远程数据库的编辑内容。


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