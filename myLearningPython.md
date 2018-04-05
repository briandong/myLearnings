[TOC]

# My Learning Python

## variables变量

支持多变量赋值；python 3.5以后必须严格使用print()格式

```python
a, b, c = 1, 2, 3
print(a, b, c)  #=> 1 2 3
```

### 局部变量
```python
def fun():
    a = 10  # 局部变量
    return a+100

print(a)    #=> 报错, 不能拿到一个局部变量的值
```

### 全局变量

使用global可以在局部修改全局变量

```python
APPLY = 100 # 全局变量
a = None
def fun():
    global a    # 使用之前在全局里定义的 a
    a = 20      # 现在的 a 是全局变量了
    return a+100

print(APPLE)         #=> 100
print('a past:', a)  #=> None
fun()
print('a now:', a)   #=> 20
```

## input

```python
a_input=input('please input a number:')
print('this number is:',a_input)

please input a number:12 #12 是我在硬盘中输入的数字
#=> this number is: 12
```

## 循环

### while循环

```python
condition = 1
while condition < 4:
	print(condition)
	condition += 1
	
#=> 1
#=> 2
#=> 3
```

### for循环
使用list
```python
example_list = [1,2,3]
for i in example_list:
    print(2**i)

#=> 2
#=> 4
#=> 8
```

使用range
```python
for i in range(1,4):
    print(2**i)
    
#=> 2
#=> 4
#=> 8
```

使用range step
```python
for i in range(1,6,2):
    print(i)
    
#=> 1
#=> 3
#=> 5
```

### continue & break

```python
while True:
    b= input('type somesthing:')
    if b=='1':
        continue
    elif b=='2':
        break
    else:
        pass
    print('still in while')
print ('finish run')

"""
type somesthing:4
still in while
type somesthing:1
type somesthing:2
finish run
"""
```

## if条件
### if
```python
x, y, z = 1, 2, 3
if x<y<z:
    print('x is less than y, and y is less than z')

#=> x is less than y, and y is less than z
```

### if-else
```python
x, y = 1, 2
if x<y:
    print('x is less than y')
else:
    print('x is equal to or greater than y')

#=> x is less than y
```

### if-elif-else
```python
x, y = 1, 2
if x<y:
    print('x is less than y')
elif x>y:
    print('x is greater than y')
else:
    print('x is equal to y')
    
#=> x is less than y
```

### 自调用
```python
if __name__ == '__main__':
    #code_here
```
如果执行该脚本，if判断语句将会是True,那么内部的代码将会执行。 
如果外部调用该脚本，if判断语句则为False,内部代码将不会执行。

## def函数

### 基础
```python
def function():
    print('This is a function')
    a = 1+2
    print(a)

function()    
#=> This is a function
#=> 3
```

注意调用函数的括号不能省略

### 参数
```python
def sum(a, b):
    c = a + b
    print('the sum is ', c)

sum(2, 1) #=> the sum is 3
```

### 默认参数
```python
def sale_car(price, color='red', brand='carmy', is_second_hand=True):
    print('price', price,
          'color', color,
          'brand', brand,
          'is_second_hand', is_second_hand,)

sale_car(1000)
#=> price 1000 color red brand carmy is_second_hand True
```
注意所有的默认参数都不能出现在非默认参数的前面。

### 可变参数

```python
def report(name, *grades):
    total_grade = 0
    for grade in grades:
        total_grade += grade
    print(name, 'total grade is ', total_grade)

report('Mike', 8, 9, 10)
#=> Mike total grade is 27
```
注意可变参数在函数定义不能出现在特定参数和默认参数前面。

### 关键字参数

```python
def portrait(name, **kw):
    print('name is', name)
    for k,v in kw.items():
        print(k, v)

portrait('Mike', age=24, country='China', education='bachelor')
#=> name is Mike
#=> age 24
#=> country China
#=> education bachelor
```
注意通常来讲关键字参数是放在函数参数列表的最后。

## module模块

### 安装外部模块

```shell
$ pip install/uninstall numpy   # 这是 python2+ 版本的用法
$ pip3 install/uninstall numpy   # 这是 python3+ 版本的用法
```

### 更新外部模块

```shell
$ pip install -U numpy   # 这是 python2+ 版本的用法
$ pip3 install -U numpy   # 这是 python3+ 版本的用法
```

### import

```python
import numpy as np
import matplotlib.pyplot as plt

from time import localtime
from time import *
print(localtime())
```

## file文件

### open

```python
text='This is my first test.\nThis is the second line.\nThis the third line'
my_file=open('my file.txt','w')   #用法: open('文件名','形式'), 其中形式有'w':write;'r':read.
my_file.write(text)               #该语句会写入先前定义好的 text
my_file.close()                   #关闭文件
```

### append

```python
append_text='\nThis is appended file.'  # 为这行文字提前空行 "\n"
my_file=open('my file.txt','a')   # 'a'=append 以增加内容的形式打开
my_file.write(append_text)
my_file.close()
```

### read

#### read
```python
file= open('my file.txt','r') 
content=file.read()  
print(content)
#=> This is my first test.
#=> This is the second line.
#=> This the third line.
#=> This is appended file.    
```

#### readline
```python
file= open('my file.txt','r') 
content=file.readline()  # 读取第一行
print(content)  #=> This is my first test.
second_read_time=file.readline()  # 读取第二行
print(second_read_time)  #=> This is the second line.
```
#### readlines

```python
file= open('my file.txt','r') 
content=file.readlines() # python_list 形式
print(content)
#=> ['This is my first test.\n', 'This is the second line.\n', 'This the third line.\n', 'This is appended file.']

for item in content:
    print(item)
#=> This is my first test.
#=> This is the second line.
#=> This the third line.
#=> This is appended file.  
```

## class类
class 定义一个类, 后面的类别首字母推荐以大写的形式定义
```python
class Calculator:       #首字母要大写，冒号不能缺
    name='Good Calculator'  #该行为class的属性
    price=18
    def add(self,x,y):
        print(self.name)
        result = x + y
        print(result)
    def minus(self,x,y):
        result=x-y
        print(result)
    def times(self,x,y):
        print(x*y)
    def divide(self,x,y):
        print(x/y)

cal=Calculator()  #注意这里运行class的时候要加"()",否则调用下面函数的时候会出现错误,导致无法调用.
cal.name  #=> Good Calculator
cal.price #=> 18
cal.add(10,20)
#=> Good Calculator
#=> 30
cal.minus(10,20)  #=> -10
cal.times(10,20)  #=> 200
cal.divide(10,20) #=> 0.5
```

### __init__

```python
class Calculator:
    name='good calculator'
    price=18
    def __init__(self,name,price,height,width,weight):   # 注意，这里的下划线是双下划线
        self.name=name
        self.price=price
        self.h=height
        self.wi=width
        self.we=weight

c=Calculator('bad calculator',18,17,16,15)
c.name  #=> 'bad calculator'
c.price #=> 18
c.h  #=> 17
c.wi #=> 16
c.we #=> 15
```

## 数据结构

### list
list是以中括号来命名
```python
a_list = [12, 3, 67, 7, 82]

for content in a_list:
    print(content)

#=> 12
#=> 3
#=> 67
#=> 7
#=> 82
```

多维list
```python
multi_dim_a = [[1,2,3],
			   [2,3,4],
			   [3,4,5]] 

print(multi_dim_a[2][2])  #=> 5
```

### tuple
tuple用小括号、或者无括号来表述，是一连串有顺序的数字。
```python
a_tuple = (12, 3, 5, 15 , 6)
another_tuple = 12, 3, 5, 15 , 6

for index in range(len(a_tuple)):
    print("index = ", index, ", number in tuple = ", a_tuple[index])

#=> index =  0 , number in tuple =  12
#=> index =  1 , number in tuple =  3
#=> index =  2 , number in tuple =  5
#=> index =  3 , number in tuple =  15
#=> index =  4 , number in tuple =  6
```

tuple是不可变的list，一旦声明就无法改变


### dictionary

```python
d1 = {'apple':1, 'pear':2, 'orange':3}
d2 = {1:'a', 2:'b', 3:'c'}
d3 = {1:'a', 'b':2, 'c':3}

print(d1['apple'])  #=> 1

del d1['pear']
print(d1)   #=> {'orange': 3, 'apple': 1}

d1['b'] = 20
print(d1)   #=> {'orange': 3, 'b': 20, 'pear': 2, 'apple': 1}
```

### type
type返回一个对象的类型
```python
a=[1,2,3]
type(a)  #=> <class 'list'>
```

## try exception错误处理

```python
try:
    file=open('eeee.txt','r+')
except Exception as e:
    print(e)
    response = input('do you want to create a new file:')
    if response=='y':
        file=open('eeee.txt','w')
    else:
        pass
else:
    file.write('ssss')
    file.close()
```

## process
### zip
zip函数接受任意多个（包括0个和1个）序列作为参数，合并后返回一个tuple列表

```python
a=[1,2,3]
b=[4,5,6]
ab=zip(a,b)
print(list(ab))  #需要加list来可视化这个功能
#=> [(1, 4), (2, 5), (3, 6)]
for i,j in zip(a,b):
     print(i/2,j*2)
#=> 0.5 8
#=> 1.0 10
#=> 1.5 12
```

### lambda
lambda定义一个简单的函数，实现简化代码的功能
```python
fun= lambda x,y:x+y
x=int(input('x='))    #这里要定义int整数，否则会默认为字符串
y=int(input('y='))
print(fun(x,y))
#=> x=6
#=> y=6
#=> 12
```
### map
map是把函数和参数序列绑定在一起, 返回一个map object
```python
def fun(x,y):
    return (x+y)
list(map(fun,[1],[2]))  #=> [3]
list(map(fun,[1,2],[3,4]))  #=> [4,6]
```

## assign & copy

### id
id返回一个对象在内存中的地址
```python
a=[1,2,3]
id(a)  #=> 4382960392
```

### assign (=)
=操作对应的是指针赋值
```python
a=[1,2,3]
b=a
id(a)  #=> 4382960392
id(b)  #=> 4382960392
id(a)==id(b)    #附值后，两者的id相同，为true
#=> True
b[0]=222222  #此时，改变b的第一个值，也会导致a值改变
print(a,b)  #a,b值同时改变
#=> [222222, 2, 3] [222222, 2, 3] 
```
### copy
```python
import copy
a=[1,2,3]
c=copy.copy(a)  #拷贝了a的外围对象本身
print(id(a)==id(c))  #id 改变 为false
#=> False
c[1]=22222   #此时，我去改变c的第二个值时，a不会被改变
print(a,c)  #a值不变,c的第二个值变了，这就是copy和‘==’的不同
#=> [1, 2, 3] [1, 22222, 3]
```

### deepcopy
```python
#copy.copy()
a=[1,2,[3,4]]  #第三个值为列表[3,4],即内部元素
d=copy.copy(a) #浅拷贝a中的[3，4]内部元素的引用，非内部元素对象的本身
id(a)==id(d)  #=> False
id(a[2])==id(d[2])  #=> True
a[2][0]=3333  #改变a中内部原属列表中的第一个值
d             #这时d中的列表元素也会被改变
#=> [1, 2, [3333, 4]]

#copy.deepcopy()
e=copy.deepcopy(a) #e为深拷贝了a
a[2][0]=333 #改变a中内部元素列表第一个的值
e
#$=> [1, 2, [3333, 4]]
#因为时深拷贝，这时e中内部元素[]列表的值不会因为a中的值改变而改变
>>>
```

## pickle
pickle是一个python中，压缩/保存/提取文件的模块：
```python
import pickle

a_dict = {'da': 111, 2: [23,1,4], '23': {1:2,'d':'sad'}}

# pickle a variable to a file
file = open('pickle_example.pickle', 'wb')
pickle.dump(a_dict, file)
file.close()

# reload a file to a variable
with open('pickle_example.pickle', 'rb') as file:
    a_dict1 =pickle.load(file)

print(a_dict1)
```

## set集合

set用来产生只包含独特元素的集合：
```python
char_list = ['a', 'b', 'c', 'c', 'd', 'd', 'd']
sentence = 'Welcome Back to This Tutorial'

print(set(char_list))
#=> {'b', 'd', 'a', 'c'}
print(set(sentence))
#=> {'l', 'm', 'a', 'c', 't', 'r', 's', ' ', 'o', 'W', 'T', 'B', 'i', 'e', 'u', 'h', 'k'}
```

### add

```python
unique_char = set(char_list)
unique_char.add('x')
# unique_char.add(['y', 'z']) is wrong
print(unique_char)
#=> {'x', 'b', 'd', 'c', 'a'}
```

### remove/discard

```python
unique_char.remove('x')
print(unique_char)
#=> {'b', 'd', 'c', 'a'}

unique_char.discard('d')
print(unique_char)
#=> {'b', 'c', 'a'}
```

### clear

```python
unique_char.clear()
print(unique_char)
#=> set()
```

### difference

```python
unique_char = set(char_list)
print(unique_char.difference({'a', 'e', 'i'}))
#=> {'b', 'd', 'c'}
```

### intersection

```python
unique_char = set(char_list)
print(unique_char.intersection({'a', 'e', 'i'}))
#=> {'a'}
```

## RegEx

### 简单匹配

```python
# matching string
pattern1 = "cat"
pattern2 = "bird"
string = "dog runs to cat"
print(pattern1 in string)  #=> True
print(pattern2 in string)  #=> False
```

### re.search

```python
import re

# regular expression
pattern1 = "cat"
pattern2 = "bird"
string = "dog runs to cat"
print(re.search(pattern1, string))  #=> <_sre.SRE_Match object; span=(12, 15), match='cat'>
print(re.search(pattern2, string))  #=> None

# multiple patterns ("run" or "ran")
ptn = r"r[au]n" # start with "r" means raw string
print(re.search(ptn, "dog runs to cat"))
#=> <_sre.SRE_Match object; span=(4, 7), match='run'>
print(re.search(r"r[A-Z]n", "dog runs to cat"))
#=> None
print(re.search(r"r[a-z]n", "dog runs to cat"))
#=> <_sre.SRE_Match object; span=(4, 7), match='run'>
print(re.search(r"r[0-9]n", "dog r2ns to cat")) 
#=> <_sre.SRE_Match object; span=(4, 7), match='r2n'>
print(re.search(r"r[0-9a-z]n", "dog runs to cat"))
#=> <_sre.SRE_Match object; span=(4, 7), match='run'>
```
### 类型匹配
- \d : 任何数字
- \D : 不是数字
- \s : 任何 white space, 如 [\t\n\r\f\v]
- \S : 不是 white space
- \w : 任何大小写字母, 数字和 “” [a-zA-Z0-9]
- \W : 不是 \w
- \b : 空白字符 (只在某个字的开头或结尾)
- \B : 空白字符 (不在某个字的开头或结尾)
- \\\ : 匹配 \
- . : 匹配任何字符 (除了 \n)
- ^ : 匹配开头
- $ : 匹配结尾
- ? : 前面的字符可有可无

```python
# \d : decimal digit
print(re.search(r"r\dn", "run r4n"))           # <_sre.SRE_Match object; span=(4, 7), match='r4n'>
# \D : any non-decimal digit
print(re.search(r"r\Dn", "run r4n"))           # <_sre.SRE_Match object; span=(0, 3), match='run'>
# \s : any white space [\t\n\r\f\v]
print(re.search(r"r\sn", "r\nn r4n"))          # <_sre.SRE_Match object; span=(0, 3), match='r\nn'>
# \S : opposite to \s, any non-white space
print(re.search(r"r\Sn", "r\nn r4n"))          # <_sre.SRE_Match object; span=(4, 7), match='r4n'>
# \w : [a-zA-Z0-9_]
print(re.search(r"r\wn", "r\nn r4n"))          # <_sre.SRE_Match object; span=(4, 7), match='r4n'>
# \W : opposite to \w
print(re.search(r"r\Wn", "r\nn r4n"))          # <_sre.SRE_Match object; span=(0, 3), match='r\nn'>
# \b : empty string (only at the start or end of the word)
print(re.search(r"\bruns\b", "dog runs to cat"))    # <_sre.SRE_Match object; span=(4, 8), match='runs'>
# \B : empty string (but not at the start or end of a word)
print(re.search(r"\B runs \B", "dog   runs  to cat"))  # <_sre.SRE_Match object; span=(8, 14), match=' runs '>
# \\ : match \
print(re.search(r"runs\\", "runs\ to me"))     # <_sre.SRE_Match object; span=(0, 5), match='runs\\'>
# . : match anything (except \n)
print(re.search(r"r.n", "r[ns to me"))         # <_sre.SRE_Match object; span=(0, 3), match='r[n'>
# ^ : match line beginning
print(re.search(r"^dog", "dog runs to cat"))   # <_sre.SRE_Match object; span=(0, 3), match='dog'>
# $ : match line ending
print(re.search(r"cat$", "dog runs to cat"))   # <_sre.SRE_Match object; span=(12, 15), match='cat'>
# ? : may or may not occur
print(re.search(r"Mon(day)?", "Monday"))       # <_sre.SRE_Match object; span=(0, 6), match='Monday'>
print(re.search(r"Mon(day)?", "Mon"))          # <_sre.SRE_Match object; span=(0, 3), match='Mon'>
```

### 多行匹配

```python
string = """
dog runs to cat.
I run to dog.
"""
print(re.search(r"^I", string))
#=> None
print(re.search(r"^I", string, flags=re.M))
#=> <_sre.SRE_Match object; span=(18, 19), match='I'>
```
re.M = re.MULTILINE

### 重复匹配

- \* : 重复零次或多次
- \+ : 重复一次或多次
- {n, m} : 重复 n 至 m 次
- {n} : 重复 n 次

```python
# * : occur 0 or more times
print(re.search(r"ab*", "a"))             # <_sre.SRE_Match object; span=(0, 1), match='a'>
print(re.search(r"ab*", "abbbbb"))        # <_sre.SRE_Match object; span=(0, 6), match='abbbbb'>

# + : occur 1 or more times
print(re.search(r"ab+", "a"))             # None
print(re.search(r"ab+", "abbbbb"))        # <_sre.SRE_Match object; span=(0, 6), match='abbbbb'>

# {n, m} : occur n to m times
print(re.search(r"ab{2,10}", "a"))        # None
print(re.search(r"ab{2,10}", "abbbbb"))   # <_sre.SRE_Match object; span=(0, 6), match='abbbbb'>
```

### grouping

```python
match = re.search(r"(\d+), Date: (.+)", "ID: 021523, Date: Feb/12/2017")
print(match.group())                   # 021523, Date: Feb/12/2017
print(match.group(1))                  # 021523
print(match.group(2))                  # Date: Feb/12/2017
```

naming group

```python
match = re.search(r"(?P<id>\d+), Date: (?P<date>.+)", "ID: 021523, Date: Feb/12/2017")
print(match.group('id'))                # 021523
print(match.group('date'))              # Date: Feb/12/2017
```

### findall

findall会返回一个列表

```python
# findall
print(re.findall(r"r[ua]n", "run ran ren"))
#=> ['run', 'ran']

# | : or
print(re.findall(r"(run|ran)", "run ran ren"))
#=> ['run', 'ran']
```

### replace

```python
print(re.sub(r"r[au]ns", "catches", "dog runs to cat"))
#=> dog catches to cat
```

### split

```python
print(re.split(r"[,;\.]", "a;b,c.d;e"))
#=> ['a', 'b', 'c', 'd', 'e']
```

### compile

```python
compiled_re = re.compile(r"r[ua]n")
print(compiled_re.search("dog ran to cat"))
#=> <_sre.SRE_Match object; span=(4, 7), match='ran'>
```

## threading
TBD

## multiprocessing
TBD

## tkinter
TBD
