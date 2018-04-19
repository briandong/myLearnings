[TOC]

# myLearningRuby

## 基础
### 语法检索

生成索引：

> $ rdoc --all --ri

使用：

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
表面上attr_accessor这样的宏，其实是Kernel Module的一个方法

```ruby
class A
end

A.ancestors #=> [A, Object, Kernel, BasicObject]
```

#### include module

```ruby
module M
  def hi
    puts "M: hello"
  end
end

class A
  include M
end

A.new.hi #=> M: hello
p A.ancestors #=> [A, M, Object, Kernel, BasicObject]
```

#### extend
* include只会向类中加入实例方法，不会加入类方法
* extend (定义于Object类)则会扩展目标，不管目标是实例还是类
```ruby
module M
  def where_am_i
    p self
  end
end

class Inc
  include M
end

Inc.where_am_i #=> [exception raised]

class Empty
end

Empty.extend(M).where_am_i     #=> Empty
Empty.new.extend(M).where_am_i #=> #<Empty:0x00000002a64cb0>

class Ext
  def check	
    extend(M)
  end
end

ext_inst = Ext.new
ext_inst.check
ext_inst.where_am_i #=> #<Ext:0x000000027fbe60>
```
### DSL

```ruby
class Server
  def initialize(hostname)
    @hostname = hostname
	@sharepoints = {}
  end

  def shares(path, params)
    (params[:over] || []).each do |protocol|
      proto_shares = (@sharepoints[protocol] ||= {})
	  share_id = (params[:as] || "UNKNOWN")
	  proto_shares[share_id] = path
	end
  end
end

def server(hostname)
  yield Server.new(hostname)
end

server "bitbucket.example.com" do |srv|
  srv.shares "/homes", :over => ["afp", "smb], :as => "HOMES"
end
```

## Gem

### Website

> www.rubygems.org

### RubyGems

#### 安装

> $ ruby setup.rb

#### 获取帮助

> $ gem
>
> RubyGems is a sophisticated package manager for Ruby.  This is a
> basic help message containing pointers to more information.
>
>   Usage:
>     gem -h/--help
>     gem -v/--version
>     gem command [arguments...][options...]
>
>   Examples:
>     gem install rake
>     gem list --local
>     gem build package.gemspec
>     gem help install
>
>   Further help:
>     gem help commands            list all 'gem' commands
>     gem help examples            show some examples of usage
>     gem help gem_dependencies    gem dependencies file guide
>     gem help platforms           gem platforms guide
>     gem help <COMMAND>           show help on COMMAND
>                                    (e.g. 'gem help install')
>     gem server                   present a web page at
>                                  http://localhost:8808/
>                                  with info about installed gems
>   Further information:
>     http://guides.rubygems.org



gem_server

> $ gem_server

浏览器访问 localhost:8888

#### 更新

> $ gem update --system

###gem包

#### 搜索

> $ gem search -r fish

####安装 

> $ gem install starfish -v 1.1.3

#### 列出已安装的gem包

> $ gem list

#### 更新

> $ gem update starfish -t -y

#### 清除旧gem包

清除全部gem库

> $ gem cleanup 

清除某个gem包

> $ gem cleanup starfish

#### 删除

>  $ gem uninstall starfish

#### 使用

使用最新版本

```ruby
require "rubygems"
require "starfish"
```

指定版本号

```ruby
gem "starfish", "1.1.3"
```

* "1.1.3", "= 1.1.3"
* "! = 1.1.3"
* "> 1.1.3", "> =1.1.3"
* "< 1.1.3", "< =1.1.3"
* "~ > 1.1.3": 近似大于，即"> 1.1.3"并且"< 1.2.0" (倒数第二位+1)

### 创建gem

Todo

## Rake

### 基本任务

#### 设定缺省任务
```ruby
task :default => :test

task :test do
  ruby "tests/test1.rb"
  ruby "tests/test2b.rb"
end
```

#### 文件任务
指定依赖文件，并根据时间戳确定目标文件是否需要更新
```ruby
file "index.yaml" => ["hosts.txt", "users.txt", "groups.txt"] do
  ruby "build_index.rb"
end
```
#### 确保目录存在
```ruby
directory "html/images"
```

#### 一般化规则
```ruby
rule ".o" => ".c" do |t|
  sh "gcc", "-Wall", "-o", t.name, "-c", t.source
end
```

#### 任务合成
结合rule和FileList
```ruby
task :default => "cool_app"

o_files = FileList["*.c"].exclude("main.c").sub(/c$/, "o")

file "cool_app" => o_files do |t|
  sh "gcc", "-Wall", "-o", t.name, *(t.sources)
end

rule ".o" => ".c" do |t|
  sh "gcc", "-Wall", "-o", t.name, "-c", t.source
end
```
对于上面两个非常相似的shell指令，可以定义方法重构
```ruby
def compile(target, sources, *flags)
  sh "gcc", "-Wall", "-Werror", "-o", target, *(sources + flags)
end
```
注意*会把item自动转换成为array。
于是两个shell指令可以简化成
```ruby
compile(t.name, t.sources)
compile(t.name, [t.source], "-c")
```

#### 自动生成任务列表
使用desc增加任务描述
```ruby
desc "Run all unit tests"
task :test do
  # run the tests
end

desc "Build a performance profile"
task :perf do
  # build the profile
end
```

> rake -T
> rake test # Run all unit tests
> rake perf # Build a performance profile

## Unit Tests
### Ruby的测试库
```ruby
require "test/unit"

class MathTest < Test::Unit::TestCase
  def test_add
    assert_equal(2, 1+1)
  end
end
```
*Note: 以下指令可以获取更多断言方法
> ri Test::Unit::Assertions

### setup/teardown
```ruby
require "test/unit"

class RemoteHostTest < Test::Unit::TestCase
  def setup
    @session = RemoteHost.new("testserver.example.org")
  end
  
  def teardown
    @session.close
  end
  
  def test_echo
    assert_equal("ping", @session.echo("ping").stdout)
  end
end
```

### suite
```ruby
require "test/unit"
require "tc_math"
require "tc_linalg"
... 
```
### 使用rake测试

```ruby
Rake::TestTask.new do |t|
  t.test_files = FileList["test/tc_*.rb"]
end
```
会为rake增加test任务，并自动运行test_files。
具体可以参考
> ri Rake::TestTask

如果所有测试通过则提交代码
```ruby
desc "Commit the current working copy if all tests pass"
task :commit => :test do
  sh "git", "commit"
end
```

