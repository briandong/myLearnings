[TOC]

# My Learning Bash

## .bashrc

[.bashrc](.bashrc)

## basic

### if elif else fi
```
typ=bird

if [[ $typ == "cat" ]]; then
  echo "I love cats"
elif [[ $typ == "dog" ]]; then
  echo "I love dogs"
else
  echo "I love ${typ}s"
fi
```

## Tips

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

### output multi lines to one line
使用|xargs
```
$ echo -e "line1\nline2\nline3\nline4"
line1
line2
line3
line4
$ echo -e "line1\nline2\nline3\nline4" |xargs echo
line1 line2 line3 line4
```
使用|xargs -n甚至可以指定每行的个数
```
$ echo -e "line1\nline2\nline3\nline4" |xargs -n2 echo
line1 line2
line3 line4
$ echo -e "line1\nline2\nline3\nline4" |xargs -n3 echo
line1 line2 line3
line4
```

### create file
```
cat <<EOF > hello.py
print("hello world!")
EOF
```
