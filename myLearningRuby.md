[TOC]

# myLearningRuby

## 基础
### 语法检索

例如：
> $ ri String

> $ ri puts

检索类方法：
> $ ri SomeClass::class_method

检索对象方法：
> $ ri SomeClass#object_method

### 交互式ruby

> $ irb

### 宏
* attr_reader
* attr_writer
* attr_accessor

例如
```ruby
class Dog
  def size
    return @size
  end
  
  def size=(metres)
    @size = metres
  end 
end
```
等效于
```ruby
class Dog
  attr_accessor :size
end
```
## 快速单行代码

### hello world
* -e: 执行后续脚本，支持多个-e
> $ ruby -e 'puts "hello world"'

### grep
* -n: 为执行脚本隐式地套上一层'while gets(); ... end'
> $ ruby -ne 'puts $_ if $_ =~ /andre/' /etc/passwd /etc/group

### 处理注释
* -p: 在-n循环的基础上额外提供打印输出$_
> $ ruby -pe '$_ = "#" + $_' ruby_script.rb

* -i[extension]: 直接修改原文件，如果提供extension扩展名就备份原文件
> $ ruby -i.bak -pe '$_ = "#" + $_' *.rb

去掉所有注释行
> $ ruby -i.bak -ne 'puts $_ unless $_ =~ /^#/' *.rb

### 增加行号
* $.: 代表当前正在处理文件行号的全局变量
> $ ruby -i.bak -pe '$_ = $. + ": " + $_' *.rb

> $ ruby -ne 'open("/tmp/user_#{$.}", "w") {|f| f.puts $_ })' user_info

### 分隔字段
* -a: -n/-p时，自动把$_的内容分割到名为$F的数组
> $ ruby -a -ne 'open("/tmp/user_#{$.}", "w") {|f| f.puts $F })' user_info

* -Fpattern: -a时指定分隔符pattern
> $ ruby -a -F, -i -ne 'puts $F.values_at(1, 0, 2, 3).join("\t")' contacts

### 分隔记录
* -0[octal]: 指定记录分隔符（八进制编码），默认是换行符
> $ ruby -015 -ne 'puts $_ if $_ =~ /foot/' /usr/share/dict/mac_words

> (015是老式Mac回车符\r的编码)

* -l: 处理完成后把记录分隔符自动加回到末尾
> $ ruby -015 -l -pe '$_ = $_.size' /usr/share/dict/mac_words

### 路径

> $ ruby -e 'puts Dir["*.c"].find{|f| File.size(f) > 1024}.sort_by{|f| file.mtime(f)}'

### 定时监控

> $ ruby -e 'system "clear; ls -lahG" while sleep 1'

### require library

* -rlibrary: 执行代码前包含需要的库
> $ ruby -rfileutils -e '...'

## 性能

### 性能分析

#### time (UNIX)

> $ time ruby -e '10000.times {1+2}'
>
> real    0m0.164s
> user    0m0.000s
> sys     0m0.015s

* real: 总时间
* user: 用户操作
* sys: 系统操作
* real - (user + sys) = 进程挂起等待时间


#### Benchmark (Ruby)

##### 性能基准测量

```ruby
require "benchmark"
require "pp"

integers = (1..100000).to_a
pp Benchmark.measure {integers.map {|i| i*i}}
```
> #<Benchmark::Tms:0x0000000003acac08
>  @cstime=0.0,
>  @cutime=0.0,
>  @label="",
>  @real=0.01246070900003815,
>  @stime=0.0,
>  @total=0.016,
>  @utime=0.016>

* total = stime + utime

##### 不同算法的性能基准测量

```ruby
require "benchmark"

Benchmark.bm(10) do |b|
    b.report("simple") {50000.times {1+2}}
    b.report("complex") {50000.times {1+2+3-2-4+5-3}}
    b.report("stupid") {50000.times {("1".to_i + "2".to_i).to_s.to_i}}
end
```

>                                 user     system      total        real
>                 simple       0.000000   0.000000   0.000000 (  0.001822)
>                 complex      0.000000   0.000000   0.000000 (  0.002656)
>                 stupid       0.016000   0.000000   0.016000 (  0.012924)

* 传递给bm的参数10代表了打印表格的列宽

##### 带彩排的性能基准测量

```ruby
require "benchmark"

Benchmark.bmbm(10) do |b|
    b.report("readlines") do
		IO.readlines("testfile").find {|line| line =~ /radish/}
	end
    b.report("each") do
		found_line = nil
		File.open("testfile").each do |line|
			if line =~ /radish/
				found_line = line
				break
			end
		end
	end
end
```

#### Profiler (Ruby)

##### 简单性能分析
```ruby
require "profile"

def factorial(n)
	n>1? n*factorial(n-1):1
end

factorial(10000)
```

>   %   cumulative   self                            self     total
>  time   seconds   seconds    calls  ms/call  ms/call  name
>  65.96     0.09      0.09    10000    0.01     61.53  Object#factorial
>  34.04     0.14      0.05     9987     0.00       0.00  Integer#*
>   0.00      0.14      0.00            1     0.00       0.00  Module#method_added
>   0.00      0.14      0.00            1     0.00       0.00  TracePoint#disable
>   0.00      0.14      0.00            1     0.00       0.00  TracePoint#enable
>   0.00      0.14      0.00            1     0.00   141.00  #toplevel

##### 细粒度性能分析
```ruby
require "profile"

def factorial(n)
    (2..n).to_a.inject(1) {|product, i| product*i}
end

Profiler__.start_profile
factorial(10000)
Profiler__.stop_profile
Profiler__.print_profile($stdout)
```

### 性能优化

#### 算法优化
```ruby
# slow, 13.42sec
words = []
paragraph.each do |word|
    words << word unless words.include?(word)
end

# versus 0.04sec
words = {}
paragraph.each do |word|
    words[word] = nil
end
words = words.keys
```
#### 语句优化
```ruby
require "benchmark"

NUM_TRIALS = 10**7
Benchmark.bmbm(10) do |b|
    b.report("symbol") do
        NUM_TRIALS.times {me = :andre} #faster
    end
    b.report("string") do
        NUM_TRIALS.times {me = "andre"} #slower
    end
end
```
#### 减轻内存分配等副作用
```ruby
class Employee
  def initialize
    @embezzled = []
  end
  
  def embezzle(amout)
    @embezzled << amount
  end
  
  def embezzled_total
    @embezzled.inject(0) {|sum, amount| sum+amount}
  end
end
```

Versus...
```ruby
class Employee
  def initialize
    @embezzled = nil
  end
  
  def embezzle(amout)
    (@embezzled ||= []) << amount
  end
  
  def embezzled_total
    (@embezzled || []).inject(0) {|sum, amount| sum+amount}
  end
end
```

#### 嵌入C代码
```ruby
require "inline"

inline do |builder|
  builder.c "int func" {
    ... #some c code
  }
end
```

## 元编程

### 灵活的方法签名
#### 默认值
```ruby
def rolecall(person1, person2 = "Dick", person3 = "Harry")
  "#{person1}, #{person2} and #{person3}"
end

rolecall("Tom")         #=> "Tom, Dick and Harry"
rolecall("George", 42)  #=> "George, 42 and Harry"
```
#### Hash参数
```ruby
def install_package(name, params = {})
  path = (params[:path] || "/")
  receipt = (params[:receipt] || true)
  # do something with package name, path, and receipt flag
end

install_package("Tux Racer", :path => "/games") 等价于
install_package("Tux Racer", {:path => "/games"})
```
#### method_missing
Rails实例
```ruby
def method_missing(symbol, *args)
  if symbol.to_s =~ /^find_by_(\w+)$/
    fields = $1.split("_and_")
    # build a query based on the fields and args (array)
  else super
  end
end
```

### 宏
