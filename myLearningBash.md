[TOC]

# My Learning Bash

[.bashrc](.bashrc)

## Tips

### echo new line in string
使用echo -e或是printf
```
$ echo "this is the 1st line\nthis is the 2nd line\n"
this is the 1st line\nthis is the 2nd line\n

$ echo -e "this is the 1st line\nthis is the 2nd line\n"
this is the 1st line
this is the 2nd line

$ printf "this is the 1st line\nthis is the 2nd line\n"
this is the 1st line
this is the 2nd line
```

### #{}
#{}主要是用来消除表达式的歧义
```
$ var=great
$ echo $varspeach

$ echo ${var}speach
greatspeach
```

### #()
#()用来执行并返回指令
```
$ echo "Today is $(date). A fine day."
Today is Wed May 29 16:32:11 CST 2019. A fine day.
```
