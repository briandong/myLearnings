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

> hello world

### grep
* -n: 为执行脚本隐式地套上一层'while gets(); ... end'
> $ ruby -ne 'puts $_ if $_ =~ /andre/' /etc/passwd /etc/group

### 处理注释
* -p: 在-n循环的基础上额外提供打印输出$_
> $ ruby -pe '$_ = "#" + $_' ruby_script.rb

* -i: 直接修改原文件，如果提供扩展名就备份原文件
> $ ruby -i.bak -pe '$_ = "#" + $_' *.rb

去掉所有注释行
> $ ruby -i.bak -ne 'puts $_ unless $_ =~ /^#/' *.rb

### 增加行号
* $.: 代表当前正在处理文件行号的全局变量
> $ ruby -i.bak -pe '$_ = $. + ": " + $_' *.rb

> $ ruby -ne 'open("/tmp/user_#{$.}", "w") {|f| f.puts $_ })' user_info

### 分割字段
* -a: -n/-p时，自动把$_的内容分割到名为$F的数组
> $ ruby -a -ne 'open("/tmp/user_#{$.}", "w") {|f| f.puts $F })' user_info
