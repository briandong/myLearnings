[TOC]

# Python

## Setup Environment

### Install Python
可以从官方网站（https://www.python.org/downloads/）单独安装python。

更推荐安装集成了python和大量常用data science package的anaconda platform (https://www.anaconda.com/distribution/)。

### Install IDE

* VS Code (由anaconda集成)
* pycharm (https://www.jetbrains.com/pycharm/)

### 全局环境

可以使用pip来管理全局环境，安装、卸载package。

确保pip的版本是最新的：

> $ python -m pip install -U pip

安装package：

> $ pip install PACKAGE

卸载package：

> $ pip uninstall PACKAGE

list已安装package：

> $ pip list

search任意package：

> $ pip search PACKAGE

### 虚拟环境 pipenv

可以使用pipenv来创建和管理虚拟环境、以及在虚拟环境中安装和卸载依赖包。

pipenv是新一代虚拟环境管理工具，可以把它看做是pip和virtualenv的组合体。

全局安装pipenv：

> $ pip install pipenv

为当前项目创建一个虚拟环境：

> $ pipenv install

激活虚拟环境（执行 `exit` 可以退出虚拟环境）

> $ pipenv shell

此外，pipenv还提供了一个`pipenv run`命令，在该命令后附加的参数会直接作为命令在虚拟环境中执行，例如：

> $ pipenv run pip list

## 项目文件结构

由Kenneth Reitz推荐的目录结构：

> README.rst
> LICENSE
> setup.py
> requirements.txt
> sample/\__init__.py
> sample/core.py
> sample/helpers.py
> docs/conf.py
> docs/index.rst
> tests/test_basic.py
> tests/test_advanced.py

仓库可以在这里找到：https://github.com/navdeep-G/samplemod

## Coding Styles

### 明确的代码

在存在各种黑魔法的Python中，我们提倡最明确和直接的编码方式。

```python
# 差
def make_complex(*args):
    x, y = args
    return dict(**locals())

# 好
def make_complex(x, y):
    return {'x': x, 'y': y}
```

在上述好的代码中，x和y以明确的字典形式返回给调用者。

### 每行一个声明

复合语句（比如说列表推导）因其简洁和表达性受到推崇，但在同一行代码中写两条独立的语句是糟糕的。

```python
# 差
print 'one'; print 'two'

if x == 1: print 'one'

if <complex comparison> and <other complex comparison>:
    # do something
    
# 好
print 'one'
print 'two'

if x == 1:
    print 'one'

cond1 = <complex comparison>
cond2 = <other complex comparison>
if cond1 and cond2:
    # do something
```

### 函数参数

将参数传递给函数有四种不同的方式：

1. **位置参数** 是强制的，且没有默认值。适用于一些这样的函数参数中：它们是函数意义的完整部分，其顺序是自然的。比如：`point(x, y)` 。

2. **关键字参数** 是非强制的，且有默认值。当一个函数有超过两个或三个位置参数时，函数签名会变得难以记忆，使用带有默认参数 的关键字参数将会带来帮助。比如，`send(message, to, cc=None, bcc=None)`。

3. **任意参数列表** 如果函数的目的通过带有数目可扩展的位置参数的签名能够更好的表达，该函数可以被定义成 `*args` 的结构。在这个函数体中， `args` 是一个元组，它包含所有剩余的位置参数。举个例子， 我们可以用任何容器作为参数去 调用 `send(message, *args)` ，比如 `send('Hello', 'God', 'Mom','Cthulhu')`。 在此函数体中， `args` 相当于 `('God','Mom', 'Cthulhu')`。

4. **任意关键字参数字典** 如果函数要求一系列待定的命名参数，我们可以使用 `**kwargs` 的结构。在函数体中， `kwargs` 是一个字典，它包含所有传递给函数但没有被其他关键字参数捕捉的命名参数。

   ```python
   def send(message, **kwargs):
       print(kwargs)
       
   send('Hello', to='God', cc='Mom', bcc='Cthulhu')
   # {'to': 'God', 'cc': 'Mom', 'bcc': 'Cthulhu'}
   ```

### 避免魔法方法

Python对骇客来说是一个强有力的工具，它拥有非常丰富的钩子（hook）和工具。尽管如此，所有的这些选择都有许多缺点，最主要的缺点是可读性不高。

使用更加直接的方式来达成目标通常是更好的方法。

### 我们都是负责任的用户

Python允许很多技巧，其中一些具有潜在的危险。一个好的例子是：任何客户端代码能够重写一个对象的属性和方法。这种哲学是在说：“我们都是负责任的用户”，它和高度防御性的语言（如Java）有着非常大的不同。

私有属性的主要约定和实现细节是在所有的“内部”变量前加一个下划线。如果客户端代码打破了这条规则并访问了带有下划线的变量，那么因内部代码的改变而出现的任何不当的行为或问题，都是客户端代码的责任。

### 返回值

在函数中返回结果主要有两种情况：函数正常运行并返回它的结果，以及错误的情况。

函数正常运行最好保持单个出口点。

如果在面对第二种情况时不想抛出异常，可能需要返回一个值（比如说None或False）来表明函数无法正确运行。

```python
def complex_function(a, b, c):
    if not a:
        return None  # 抛出一个异常可能会更好
    if not b:
        return None  # 抛出一个异常可能会更好

    # 一些复杂的代码试着用a,b,c来计算x
    # 如果成功了，抵制住返回x的诱惑
    if not x:
        # 一些关于x的计算的Plan-B
    return x  # 返回值x只有一个出口点有利于维护代码
```

### 解包 unpacking

如果知道一个列表或者元组的长度，可以将其解包并为它的元素取名。比如，`enumerate()` 会对list中的每个项提供包含两个元素的元组：

```python
for index, item in enumerate(some_list):
    # 使用index和item做一些工作
```

还有其他解包的用法：

```python
a, b = b, a  # 交换变量
a, (b, c) = 1, (2, 3)  # 嵌套解包

a, *rest = [1, 2, 3]
# a = 1, rest = [2, 3]
a, *middle, c = [1, 2, 3, 4]
# a = 1, middle = [2, 3], c = 4
```

### 创建被忽略的变量

如果需要赋值（比如解包的时候）但又不需要这个变量，请使用 `__`:

```python
filename = 'foobar.txt'
basename, __, ext = filename.rpartition('.')
```

### 创建一个含N个对象的列表

```python
four_nones = [None] * 4
# [None, None, None, None]
```

### 创建一个含N个列表的列表

```python
four_lists = [[] for __ in range(4)]
# [[], [], [], []]
```

### 根据列表来创建字符串

创建字符串的一个常见习语是在空的字符串上使用 [`str.join()`](https://docs.python.org/3/library/stdtypes.html#str.join) 。

```python
letters = ['s', 'p', 'a', 'm']
word = ''.join(letters)
# spam
```

### 在集合体collection中查找一个项

有时我们需要在集合体中查找。让我们看看这两个选择：列表和集合（set）。

```python
s = set(['s', 'p', 'a', 'm'])
l = ['s', 'p', 'a', 'm']

def lookup_set(s):
    return 's' in s

def lookup_list(l):
    return 's' in l
```

即使两个函数看起来完全一样，但因为 *查找集合* 利用了Python中的集合是可哈希的特性，两者的查询性能是非常不同的。为了判断一个项是否在列表中，Python将会查看每个项直到它找到匹配的项。这是耗时的，尤其是对长列表而言。另一方面，在集合中，项的哈希值将会告诉Python在集合的哪里去查找匹配的项。结果是，即使集合很大，查询的速度也很快。在字典中查询也是同样的原理。

因为这些性能上的差异，在下列场合在使用集合或者字典而不是列表，通常会是个好主意：

- 集合体中包含大量的项
- 您将在集合体中重复地查找项
- 您没有重复的项

### 检查变量是否等于常量

```python
# 差
if attr == True:
    print 'True!'

if attr == None:
    print 'attr is None!'
    
# 好
# 检查值
if attr:
    print 'attr is truthy!'

# 或者做相反的检查
if not attr:
    print 'attr is falsey!'

# or, since None is considered false, explicitly check for it
if attr is None:
    print 'attr is None!'
```

### 访问字典元素

不要使用 `dict.has_key()` 方法，使用 `x in d` 语法，或者 将一个默认参数传递给 [`dict.get()`](https://docs.python.org/3/library/stdtypes.html#dict.get)。

```python
d = {'hello': 'world'}

# 差
if d.has_key('hello'):
    print d['hello']    # 打印 'world'
else:
    print 'default_value'

# 好
if 'hello' in d:
    print d['hello']

# 好
print d.get('hello', 'default_value') # 打印 'world'
print d.get('thingy', 'default_value') # 打印 'default_value'
```

### lambda

lambda是python支持一种有趣的语法，它允许你快速定义单行函数。

**lambda表达式**返回一个函数对象，例如：

```python
func = lambda x,y:x+y
# 相当于
def func(x,y):
    return x+y
```



### 维护列表的捷径

#### list comprehensions

[列表推导](http://docs.python.org/tutorial/datastructures.html#list-comprehensions) 提供了一个强大的而又简洁的方式来处理列表。

```python
# 差
squares = []
for x in range(10):
    squares.append(x**2)

# 好
squares = [x**2 for x in range(10)]

# [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

列表推导由中括号构成，里面包含一个表达式和for语句，然后是0个或多个for/if语句。

```python
[(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
# [(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
```

#### map()

```python
map(f, iterable)
# 可以近似看作
[f(x) for x in iterable]
```

例如：

```python
l = ['1','2','3','4']
list(map(int,l)) # python3和python2中map()的返回值不一样，python2中直接返回列表，python3返回一个迭代器，需要加list()转换
# [1, 2, 3, 4]


# 可以同时操作多个list
list(map(lambda x,y: x+y,l,l))
# [2, 4, 6, 8]
```

#### filter()

filter()按照函数f的规则在列表iterable中筛选数据。

```python
filter(f, iterable)
# 可以近似看作
[x for x in iterable if f(x)]
```

例如：

```python
l =[1,2,3,4]
list(filter(lambda x: x>2, l)) # python3和python2中filter()的返回值不一样，python2中直接返回列表，python3返回一个迭代器，需要加list()转换
# [3, 4]
```

#### reduce()

reduce()将列表iterable中的数据，按照函数f累计操作。如将第一个和第二个数据进行f操作，得到的结果再和第三个数据进行f操作，以此类推一直循环下去。

```python
from functools import reduce # python3从全局空间移除了reduce

l =[1, 2, 3, 4]
reduce(lambda x,y: x+y, l)
# 10
```

### 在列表中修改值

请记住，赋值永远不会创建新对象。如果两个或多个变量引用相同的列表，则修改其中一个变量意味着将修改所有变量。

```python
# 差
a = [3, 4, 5]
b = a                     # a 和 b 都指向一个列表独享
# 所有的列表成员都加 3
for i in range(len(a)):
    a[i] += 3             # b[i] 也改变了
    
# 好
a = [3, 4, 5]
b = a
# 给变量 "a" 赋值新的列表，而不改变 "b"
a = [i + 3 for i in a]
# 或者 (Python 3.x)
a = list(map(lambda i: i + 3, a))
```

### enumerate()

使用 [`enumerate()`](https://docs.python.org/3/library/functions.html#enumerate) 获得列表中的当前位置的计数。

```python
a = [3, 4, 5]
for i, item in enumerate(a):
    print i, item

# 0 3
# 1 4
# 2 5
```

使用 [`enumerate()`](https://docs.python.org/3/library/functions.html#enumerate) 函数比手动维护计数有更好的可读性。而且，它对迭代器 进行了更好的优化。

### 读取文件

使用 `with open` 语法来读取文件。它将会为您自动关闭文件。

```python
# 差
f = open('file.txt')
a = f.read()
print a
f.close()

# 好
with open('file.txt') as f:
    for line in f:
        print line
```

### 行的延续

当一个代码逻辑行的长度超过可接受的限度时，您需要将之分为多个物理行。如果行的结尾 是一个反斜杠（\），Python解释器会把这些连续行拼接在一起。这在某些情况下很有帮助，但我们总是应该避免使用，因为它的脆弱性：如果在行的结尾，在反斜杠后加了空格，这会 破坏代码，而且可能有意想不到的结果。

一个更好的解决方案是在元素周围使用括号。左边以一个未闭合的括号开头，Python 解释器会把行的结尾和下一行连接起来直到遇到闭合的括号。同样的行为适用中括号和大括号。

```python
# 差
my_very_big_string = """For a long time I used to go to bed early. Sometimes, \
    when I had put out my candle, my eyes would close so quickly that I had not even \
    time to say “I’m going to sleep.”"""

from some.deep.module.inside.a.module import a_nice_function, another_nice_function, \
    yet_another_nice_function
    
# 好
my_very_big_string = (
    "For a long time I used to go to bed early. Sometimes, "
    "when I had put out my candle, my eyes would close so quickly "
    "that I had not even time to say “I’m going to sleep.”"
)

from some.deep.module.inside.a.module import (
    a_nice_function, another_nice_function, yet_another_nice_function)
```

### 模块 module

#### 模块命名

模块名称要短、使用小写，并避免使用特殊符号，比如点(.) 和问号(?)。

请尽量保持模块名称简单，以无需分开单词。 最重要的是，不要使用下划线命名空间，而是使用子模块。

```python
# OK
import library.plugin.foo
# not OK
import library.foo_plugin
```

#### import机制

举例来说，`import modu` 语句将 寻找合适的文件，即调用目录下的 `modu.py` 文件（如果该文件存在）。如果没有 找到这份文件，Python解释器递归地在 "PYTHONPATH" 环境变量中查找该文件，如果仍没 有找到，将抛出ImportError异常。

一旦找到 `modu.py`，Python解释器将在隔离的作用域内执行这个模块。所有顶层 语句都会被执行，包括其他的引用。方法与类的定义将会存储到模块的字典中。然后，这个 模块的变量、方法和类通过命名空间暴露给调用方，这是Python中特别有用和强大的核心概念。

也可以使用import语句的特殊形式 `from modu import *` ，但使用`from modu import *`的代码较难阅读而且依赖独立性不足。它和 `import modu` 相比唯一的优点是之后使用方法时可以少打点儿字。

```python
# 差
from modu import *
[...]
x = sqrt(4)  # sqrt是模块modu的一部分么？或是内建函数么？上文定义了么？

# 稍好
from modu import sqrt
[...]
x = sqrt(4)  # 如果在import语句与这条语句之间，sqrt没有被重复定义，它也许是模块modu的一部分

# 最好
import modu
[...]
x = modu.sqrt(4)  # sqrt显然是属于模块modu的。
```

### 包 package

任意包含 `__init__.py` 文件的目录都被认为是一个Python包。导入一个包里不同 模块的方式和普通的导入模块方式相似，特别的地方是 `__init__.py` 文件将集合 所有包范围内的定义。

`pack/` 目录下的 `modu.py` 文件通过 `import pack.modu` 语句导入。 该语句会在 `pack` 目录下寻找 `__init__.py` 文件，并执行其中所有顶层 语句。以上操作之后，`modu.py` 内定义的所有变量、方法和类在`pack.modu`命名空 间中均可看到。

如果 包内的模块和子包没有代码共享的需求，使用空白的 `__init__.py` 文件是正常 甚至好的做法。

最后，导入深层嵌套的包可用这个方便的语法：`import very.deep.module as mod`。 该语法允许使用 `mod` 替代冗长的 `very.deep.module`。

### 面向对象编程 OOP

总之，对于某些架构而言，纯函数比类和对象在构建模块时更有效率，因为他们没有任何 上下文和副作用。但显然在很多情况下，面向对象编程是有用甚至必要的。例如图形桌面 应用或游戏的开发过程中，操作的元素(窗口、按钮、角色、车辆)在计算机内存里拥有相 对较长的生命周期。

### 装饰器 decorator

装饰器是一个函数或类，它可以 包装(或装饰)一个函数或方法。被 '装饰' 的函数或方法会替换原来的函数或方法。

```python
def foo():
    # 实现语句

def decorator(func):
    # 操作func语句
    return func

foo = decorator(foo)  # 手动装饰

# 使用@decorators语法装饰
@decorator
def bar():
    # 实现语句
# bar()被装饰了
```

### 上下文管理器 context manager

上下文管理器是一个Python对象，为操作提供了额外的上下文信息。这种额外的信息， 在使用 `with` 语句初始化上下文，以及完成 `with` 块中的所有代码时，采用可调用的形式。例如人们熟知的打开文件：

```python
with open('file.txt') as f:
    contents = f.read()
```

文件的`close` 方法会在某个时候被调用。

实现这个功能有两种简单的方法：使用类或使用生成器。

如果封装的逻辑量很大，则类的方法可能会更好。 而对于处理简单操作的情况，函数方法可能会更好。

#### 类方式

```python
class CustomOpen(object):
    def __init__(self, filename):
        self.file = open(filename)

    def __enter__(self):
        return self.file

    def __exit__(self, ctx_type, ctx_value, ctx_traceback):
        self.file.close()

with CustomOpen('file') as f:
    contents = f.read()
```

#### 生成器方式

生成器方式使用了Python自带的 [contextlib](https://docs.python.org/2/library/contextlib.html):

```python
from contextlib import contextmanager

@contextmanager
def custom_open(filename):
    f = open(filename)
    try:
        yield f
    finally:
        f.close()

with custom_open('file') as f:
    contents = f.read()
```

### 动态类型

Python是动态类型语言，这意味着变量并没有固定的类型。这个特性可能会导致复杂度提升和难以调试的代码。

避免对不同类型的对象使用同一个变量名：

```python
# 差
items = 'a b c d'  # 首先指向字符串...
items = items.split(' ')  # ...变为列表
items = set(items)  # ...再变为集合

# 差
a = 1
a = 'a string'
def a():
    pass  # 实现代码

# 好
count = 1
msg = 'a string'
def func():
    pass  # 实现代码
```

### 可变和不可变类型

典型的可变类型包括列表与字典，不可变类型包括变量、字符串和元组tuple。

```python
x = 6
x = x + 1  # x 变量是一个新的变量
```

```python
# 创建将0到19连接起来的字符串 (例 "012..1819")

# 差
nums = ""
for n in range(20):
    nums += str(n)   # 慢且低效
print nums

# 好
nums = []
for n in range(20):
    nums.append(str(n))
print "".join(nums)  # 更高效

# 更好
nums = [str(n) for n in range(20)]
print "".join(nums)

# 最好
nums = map(str, range(20))
print "".join(nums)
```



## Python之禅 PEP 20

又名 [**PEP 20**](https://www.python.org/dev/peps/pep-0020), Python设计的指导原则。

> \>>> import this
> The Zen of Python, by Tim Peters
>
> Beautiful is better than ugly.
> Explicit is better than implicit.
> Simple is better than complex.
> Complex is better than complicated.
> Flat is better than nested.
> Sparse is better than dense.
> Readability counts.
> Special cases aren't special enough to break the rules.
> Although practicality beats purity.
> Errors should never pass silently.
> Unless explicitly silenced.
> In the face of ambiguity, refuse the temptation to guess.
> There should be one-- and preferably only one --obvious way to do it.
> Although that way may not be obvious at first unless you're Dutch.
> Now is better than never.
> Although never is often better than *right* now.
> If the implementation is hard to explain, it's a bad idea.
> If the implementation is easy to explain, it may be a good idea.
> Namespaces are one honking great idea -- let's do more of those!
>
> 
>
> Python之禅 by Tim Peters
>
> 优美胜于丑陋（Python以编写优美的代码为目标）
> 明了胜于晦涩（优美的代码应当是明了的，命名规范，风格相似）
> 简洁胜于复杂（优美的代码应当是简洁的，不要有复杂的内部实现）
> 复杂胜于凌乱（如果复杂不可避免，那代码间也不能有难懂的关系，要保持接口简洁）
> 扁平胜于嵌套（优美的代码应当是扁平的，不能有太多的嵌套）
> 间隔胜于紧凑（优美的代码有适当的间隔，不要奢望一行代码解决问题）
> 可读性很重要（优美的代码是可读的）
> 即便假借特例的实用性之名，也不可违背这些规则（这些规则至高无上）
> 不要包容所有错误，除非您确定需要这样做（精准地捕获异常，不写 except:pass 风格的代码）
> 当存在多种可能，不要尝试去猜测
> 而是尽量找一种，最好是唯一一种明显的解决方案（如果不确定，就用穷举法）
> 虽然这并不容易，因为您不是 Python 之父（这里的 Dutch 是指 Guido ）
> 做也许好过不做，但不假思索就动手还不如不做（动手之前要细思量）
> 如果您无法向人描述您的方案，那肯定不是一个好方案；反之亦然（方案测评标准）
> 命名空间是一种绝妙的理念，我们应当多加利用（倡导与号召）

## PEP 8

[**PEP 8**](https://www.python.org/dev/peps/pep-0008) 是Python事实上的代码风格指南，我们可以在 [pep8.org](http://pep8.org/) 上获得高质量的、一度的PEP 8版本。

### pycodestyle

程序 [pycodestyle](https://github.com/PyCQA/pycodestyle)，可以检查代码一致性。安装：

> $ pip install pycodestyle

然后，对一个文件或者一系列的文件运行，来获得任何违规行为的报告:

> $ pycodestyle optparse.py
> optparse.py:69:11: E401 multiple imports on one line
> optparse.py:77:1: E302 expected 2 blank lines, found 1
> optparse.py:88:5: E301 expected 1 blank line, found 0
> optparse.py:222:34: W602 deprecated form of raising exception
> optparse.py:347:31: E211 whitespace before '('
> optparse.py:357:17: E201 whitespace after '{'
> optparse.py:472:29: E221 multiple spaces before operator
> optparse.py:544:21: W601 .has_key() is deprecated, use 'in'

### autopep8

程序 [autopep8](https://pypi.python.org/pypi/autopep8/) 能自动将代码格式化 成 PEP 8 风格。用以下指令安装此程序：

> $ pip install autopep8

用以下指令格式化一个文件：

> autopep8 --in-place optparse.py

不包含 `--in-place` 标志将会使得程序直接将更改的代码输出到控制台，以供审查。 `--aggressive` 标志则会执行更多实质性的变化，而且可以多次使用以达到更佳的效果。

## 代码测试

测试的通用规则：

- 测试单元应该集中于小部分的功能，并且证明它是对的。
- 每个测试单元必须完全独立。他们都能够单独运行，也可以在测试套件中运行，而不用考虑被调用的顺序。 要想实现这个规则，测试单元应该加载最新的数据集，之后再做一些清理。 这通常用方法 `setUp()` 和 `tearDown()` 处理。
- 尽量使测试单元快速运行。如果一个单独的测试单元需要较长的时间去运行，开发进度将会延迟， 测试单元将不能如期常态性运行。有时候，因为测试单元需要复杂的数据结构， 并且当它运行时每次都要加载，所以其运行时间较长。把运行吃力的测试单元放在单独的测试组件中， 并且按照需要运行其它测试单元。
- 学习使用工具，学习如何运行一个单独的测试用例。然后，当在一个模块中开发了一个功能时，经常运行这个功能的测试用例，理想情况下，一切都将自动。
- 在编码会话前后，要常常运行完整的测试组件。只有这样，您才会坚信剩余的代码不会中断。
- 实现钩子（hook）是一个非常好的主意。因为一旦把代码放入分享仓库中， 这个钩子可以运行所有的测试单元。
- 如果您在开发期间不得不打断自己的工作，写一个被打断的单元测试，它关于下一步要开发的东西。 当回到工作时，您将更快地回到原先被打断的地方，并且步入正轨。
- 当您调试代码的时候，首先需要写一个精确定位bug的测试单元。尽管这样做很难， 但是捕捉bug的单元测试在项目中很重要。
- 测试函数使用长且描述性的名字。这边的样式指导与运行代码有点不一样，运行代码更倾向于使用短的名字， 而测试函数不会直接被调用。在运行代码中，square()或者甚至sqr()这样的命名都是可以的， 但是在测试代码中，您应该这样取名test_square_of_number_2()，test_square_negative_number()。 当测试单元失败时，函数名应该显示，而且尽可能具有描述性。
- 当发生了一些问题，或者不得不改变时，如果代码中有一套不错的测试单元， 维护将很大一部分依靠测试组件解决问题，或者修改确定的行为。因此测试代码应该尽可能多读， 甚至多于运行代码。目的不明确的测试单元在这种情况下没有多少用处。
- 测试代码的另外一个用处是作为新开发人员的入门介绍。当有人需要基于现有的代码库工作时， 运行并且阅读相关的测试代码是最好的做法。他们会或者应该发现大多数困难出现的热点，以及边界的情况。 如果他们必须添加一些功能，第一步应该是添加一个测试，以确保新的功能不是一个尚未插入到界面的工作路径。

### 单元测试 unittest

创建测试用例通过继承 [`unittest.TestCase`](https://docs.python.org/3/library/unittest.html#unittest.TestCase) 来实现:

```python
import unittest

def fun(x):
    return x + 1

class MyTest(unittest.TestCase):
    def test(self):
        self.assertEqual(fun(3), 4)
```

### 文档测试

[`doctest`](https://docs.python.org/3/library/doctest.html#module-doctest) 模块查找零碎文本，就像在Python中docstrings内的交互式会话，执行那些会话以证实工作正常。

```python
def square(x):
    """返回 x 的平方。

    >>> square(2)
    4
    >>> square(-2)
    4
    """

    return x * x

if __name__ == '__main__':
    import doctest
    doctest.testmod()
```

当使用 `python module.py` 这样的命令行运行这个模块时，doctest将会运行，并会在结果不和文档字符串的描述一致时报错。



