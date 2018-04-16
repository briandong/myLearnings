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
## 单行代码

> $ ruby -e 'puts "hello world"'

> hello world
