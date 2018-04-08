[TOC]

# My Learning Numpy

## 简介

特点：
- 运算速度快：采用C语言编写
- 消耗资源少：采用的是矩阵运算，会比 python 自带的字典或者列表快好多

大量运用于：
- 数据分析
- 机器学习
- 深度学习

## 安装

```
pip3 install numpy
```
or
```
sudo apt-get install python-numpy
```
or use anaconda

## 属性

```python
import numpy as np

array = np.array([[1,2,3],[2,3,4]])
print(array)
#=> [[1 2 3]
#=>  [2 3 4]]

print('number of dim:',array.ndim) # 维度
#=> number of dim: 2
print('shape :',array.shape) # 行数和列数
#=> shape : (2, 3)
print('size:',array.size) # 元素个数
#=> size: 6
```

## 创建


### array：创建数组

可用dtype指定数据类型，默认int

```python
import numpy as np

a = np.array([2,23,4], dtype=np.float)
print(a.dtype)
#=> float64
```

### zeros：创建全0数组

```python
import numpy as np

a = np.zeros((3,4)) #数据全为0，3行4列
```

### ones：创建全1数组

```python
import numpy as np

a = np.ones((3,4),dtype = np.int) #数据为1，3行4列
```

### empty：创建空数组
其实数据非常接近0
```python
import numpy as np

a = np.empty((3,4)) #数据为empty，3行4列
```

### arrange：按指定范围创建数组

用arange创建连续数组:
```python
import numpy as np

a = np.arange(10,20,2) #10-19 的数据，2步长
print(a)
#=> [10, 12, 14, 16, 18]
```

使用reshape改变数据的形状
```python
import numpy as np

a = np.arange(12).reshape((3,4)) # 3行4列，0到11
print(a)
#=> [[ 0  1  2  3]
#=>  [ 4  5  6  7]
#=>  [ 8  9 10 11]]
```

### linspace：创建线段

同样也能进行reshape
```python
import numpy as np

a = np.linspace(1,10,4)
print(a)
#=> [ 1.  4.  7. 10.]
a = np.linspace(1,10,4).reshape((2,2))
print(a)
#=> [[ 1.,  4.],
#=>  [ 7., 10.]]
```

## 运算

### 一维矩阵
前提：
```python
import numpy as np
a=np.array([10,20,30,40]) #array([10, 20, 30, 40])
b=np.arange(4)            #array([0, 1, 2, 3])
```
#### 数学运算

```python
c=a+b  #=> array([10, 21, 32, 43])
c=a-b  #=> array([10, 19, 28, 37])
c=a*b  #=> array([0,  20, 60, 120])
c=b**2 #=> array([0, 1, 4, 9])
c=10*np.sin(a)  
#=> array([-5.44021111,  9.12945251, -9.88031624,  7.4511316 ])

```

#### 逻辑判断
```python
print(b<3)  
#=> array([ True,  True,  True, False], dtype=bool)
```
### 多维矩阵
前提：
```python
import numpy as np
a=np.array([[1,1],[0,1]])
b=np.arange(4).reshape((2,2))

print(a)
#=> [[1, 1],
#=>  [0, 1]]
print(b)
#=> [[0, 1],
#=>  [2, 3]]
```

#### 矩阵乘法运算dot


```python
c_dot = np.dot(a,b)
#array([[2, 4],
#       [2, 3]])

c_dot_2 = a.dot(b)
#array([[2, 4],
#       [2, 3]])
```

#### random

```python
import numpy as np
a=np.random.random((2,4))
#array([[ 0.94692159,  0.20821798,  0.35339414,  0.2805278 ],
#       [ 0.04836775,  0.04023552,  0.44091941,  0.21665268]])
```

#### min/max/sum

```python
np.sum(a)   # 4.4043622002745959
np.min(a)   # 0.23651223533671784
np.max(a)   # 0.90438450240606416
```
#### 行列运算

- axis=1：按行
- axis=0：按列

```python
print("a =",a)
#=> a = [[ 0.23651224  0.41900661  0.84869417  0.46456022]
#=>      [ 0.60771087  0.9043845   0.36603285  0.55746074]]

print("sum =",np.sum(a,axis=1))
#=> sum = [ 1.96877324  2.43558896]

print("min =",np.min(a,axis=0))
#=> min = [ 0.23651224  0.41900661  0.36603285  0.46456022]

print("max =",np.max(a,axis=1))
#=> max = [ 0.84869417  0.9043845 ]
```

#### 获得索引

```python
import numpy as np
A = np.arange(2,14).reshape((3,4)) 
# array([[ 2, 3, 4, 5]
#        [ 6, 7, 8, 9]
#        [10,11,12,13]])
         
print(np.argmin(A)) #最小元素的索引
#=> 0
print(np.argmax(A)) #最大元素的索引
#=> 11
```

#### 数学运算

```python
import numpy as np
A = np.arange(2,14).reshape((3,4)) 
# array([[ 2, 3, 4, 5]
#        [ 6, 7, 8, 9]
#        [10,11,12,13]])

print(np.mean(A)) #矩阵的均值
#=> 7.5
print(A.mean())   #=> 7.5
print(A.median()) #中位数
#=> 7.5

print(np.cumsum(A)) #累加
#=> [2 5 9 14 20 27 35 44 54 65 77 90]

print(np.diff(A)) #累差
#=> [[1 1 1]
#=>  [1 1 1]
#=>  [1 1 1]]

#nonzero()函数将所有非零元素的行与列坐标分割开，重构成两个分别关于行和列的矩阵:
print(np.nonzero(A))
#=> (array([0,0,0,0,1,1,1,1,2,2,2,2]),array([0,1,2,3,0,1,2,3,0,1,2,3]))

```

#### 排序
排序函数仅针对每一行进行从小到大排序操作
```python
import numpy as np
A = np.arange(14,2, -1).reshape((3,4)) 
# array([[14, 13, 12, 11],
#       [10,  9,  8,  7],
#       [ 6,  5,  4,  3]])

print(np.sort(A))    
# array([[11,12,13,14]
#        [ 7, 8, 9,10]
#        [ 3, 4, 5, 6]])
```

#### 转置

```python
print(np.transpose(A))    
print(A.T)

# array([[14,10, 6]
#        [13, 9, 5]
#        [12, 8, 4]
#        [11, 7, 3]])
# array([[14,10, 6]
#        [13, 9, 5]
#        [12, 8, 4]
#        [11, 7, 3]])
```

#### clip

```python
print(A)
# array([[14,13,12,11]
#        [10, 9, 8, 7]
#        [ 6, 5, 4, 3]])

print(np.clip(A,5,9))    
# array([[ 9, 9, 9, 9]
#        [ 9, 9, 8, 7]
#        [ 6, 5, 5, 5]])
```

## 索引

### 一维索引

```python
import numpy as np

A = np.arange(3,15)
# array([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
print(A[3])
#=> 6
```

二维矩阵的一维索引对应着行
```python
import numpy as np

A = np.arange(3,15).reshape((3,4))
# array([[ 3,  4,  5,  6]
#        [ 7,  8,  9, 10]
#        [11, 12, 13, 14]])
         
print(A[2])         
#=> [11 12 13 14]
```

### 二维索引

```python
import numpy as np

A = np.arange(3,15).reshape((3,4))
# array([[ 3,  4,  5,  6]
#        [ 7,  8,  9, 10]
#        [11, 12, 13, 14]])

print(A[1][1])
#=> 8
print(A[1, 1])
#=> 8
print(A[1, 1:3]) #切片
#=> [8 9]
```

### 与for循环结合
```python
import numpy as np

A = np.arange(3,15).reshape((3,4))
# array([[ 3,  4,  5,  6]
#        [ 7,  8,  9, 10]
#        [11, 12, 13, 14]])

#逐行打印
for row in A:
    print(row)
#=> [ 3,  4,  5, 6]
#=> [ 7,  8,  9, 10]
#=> [11, 12, 13, 14]

#逐列打印
for column in A.T:
    print(column)
#=> [ 3,  7,  11]
#=> [ 4,  8,  12]
#=> [ 5,  9,  13]
#=> [ 6, 10,  14]

```

### 迭代

```python
import numpy as np
A = np.arange(3,15).reshape((3,4))

#将多维矩阵展开成1行的数列
print(A.flatten())   
#=> array([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])

#flat是一个迭代器，本身是一个object属性
for item in A.flat:
    print(item)
#=> 3
#=> 4
...
#=> 14
```
