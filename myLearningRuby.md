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
