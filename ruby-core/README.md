# Ruby Core Concepts

## Ampersand (&) as method argument prefix

Also known as ``Proc`` to ``Block`` conversion.


-  ``Proc``: A Proc object is an encapsulation of a block of code, which can be stored in a local variable, passed to a method or another Proc, and can be **called**.

-  ``Blocks``: anonymous functions that can be passed into methods, a method executes the Block by **yielding** to it. Blocks are enclosed in a ``do / end`` statement or between brackets ``{}``, and they can have multiple arguments between two pipe ``|`` characters.


If ``&`` is prepended to a ``Proc`` argument, it converts it  into a ``Block``, and appends the ``Block`` to the method being called.  

Example:  

```ruby
def  give_a_block 
  puts 'before YIELD'
  yield
end

pr = proc { puts 'this is a proc' }

give_a_block &pr
```
Result:

```sh
before YIELD
this is a proc
```


If ``&`` is prepended to a method's argument, it converts the attached ``Block`` to a ``Proc`` and assigns the result to the argument.  

Example:  

```ruby
def give_a_proc(&block)
  puts 'befor CALL'
  block.call
end

give_a_proc { puts 'This is a block' }
```

Result:  
```sh
befor CALL
This is a block
```
<hr>  

## Splat and double splat
### Splat operator (*)
The splat operator is useful to turn an ``Array`` into an angurment list.  

Example:  
``` ruby
def my_method(*arguments)
    arguments.each do |element| 
        puts element
    end
end

arguments = [1, 2, 3, 4]

my_method(arguments)
```
Result:
```sh
1
2
3
4
```
### Double splat operator (**)
It works similar to the splat operator, but only collects **Keword arguments**, and it always generates a hash.

Example:
```ruby
def double_splat_method(**options)
  options.each do |key, value| 
    puts "Option #{key}:#{value}"
  end
  puts
end

double_splat_method(first: 'one', second: 'two', third: 'three')
```
Result:
```sh
Option first:one
Option second:two
Option third:three
```
<hr>  

## Keyword arguments

**Positional arguments:** are the normal parameters used in methods. 

```ruby 
def method_add(arg1, arg2) 
  puts arg1 + arg2
end

method_add(1, 2) # => 3 
```

**Keyword arguments:** named parameters used in methods.

```ruby
def method_add(arg1:, arg2:) 
  puts arg1 + arg2
end

method_add(arg2:2, arg1:1) # => 3 
```

In **Ruby 3.0**, positional arguments and keyword arguments will be separated. **Ruby 2.7** will warn for behaviors that will change in **Ruby 3.0**. If you see the following warnings, you need to update your code:

* Using the last argument as keyword parameters is deprecated, or  

* Passing the keyword argument as the last hash parameter is deprecated, or  

* Splitting the last argument into positional and keyword parameters is deprecated

In most cases, you can avoid the incompatibility by adding the double splat operator.

Example:

```ruby
def my_method(arg1: 1)
  p arg1
end

hash_parameter = { arg1: 100 }

# my_method(hash_parameter) => This call raises an ArgumentError

# double splat operator (**) is needed to pass keywords instead of a Hash.
my_method(**hash_parameter) # => 100
```
Example:
```ruby
def other_method(arg1, **options) 
  p arg1
end

# other_method(key: 40) => This call raises an ArgumentError

# write braces to make it an explicit hash
other_method({ key: 40 }) # => { :key => 40 }
```


<br>
<hr>  

## Unitary operators  

In Ruby, a unary operator is an operator which only takes a single 'argument' in the form of a receiver. For example, the ``-`` on ``-5`` or ``!`` on ``!true``.  

| Operator | Description |
| --- | ----------- |
| ! | Boolean not |
| ~ | Bitwise complement |
| + | Unary plus (no efect) |  
| - | Unary minus (reverse sign) |
| & | &  to_proc |
| * | * splatting |


``&`` can turn objects into ``procs/blocks`` by calling the ``to_proc`` method upon the object.  
Example:

```ruby
p ['hello', 'world'].map(&:reverse)
# => ["olleh", "dlrow"]
```

In this example ``&`` calls ``Symbol#to_proc``, it generates a special proc (block) object for the ``reverse`` method, then
``map`` returns a new array with the results of running the block once for every element in enum.

``*`` splating can be used in different scenarios:  
* Method deffinitions:

```ruby
def greeting(what, *people)
  people.each { |person| puts "#{what}, #{person}" }
end

greeting 'Hello!', 'Alice"', 'Beth', 'Carl' 
# Hello!, Alice
# Hello!, Beth
# Hello!, Carl

```
* Calling methods:
```ruby
people = ['Juan', 'Karla', 'Lucy']
greeting 'Good Evening...', *people 
# Good Evening..., Juan
# Good Evening..., Karla
# Good Evening..., Lucy

```
* Array destructuring:
```ruby
first, *list = [1,2,3,4,5]
# first = 1
# list = [2, 3, 4, 5]

*list, last = [1,2,3,4,5]
# list = [1, 2, 3, 4]
# last = 5

first, *mid, last = [1,2,3,4,5]
# first = 1
# mid = [2, 3, 4]
# last = 5
```

* Array Coercion
```ruby
array = *'hello', 'world'
# array = ["hello", "world"]

array = *(1..4)
# array = [1, 2, 3, 4]

```



<hr>  

## Useful related links:

* [https://ruby-doc.org/core-3.0.1/doc/syntax/calling_methods_rdoc.html](https://ruby-doc.org/core-3.0.1/doc/syntax/calling_methods_rdoc.html)
* [https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/](https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/)
* [https://thoughtbot.com/upcase/videos/ruby-keyword-arguments](https://thoughtbot.com/upcase/videos/ruby-keyword-arguments)
* [http://www.rubyinside.com/rubys-unary-operators-and-how-to-redefine-their-functionality-5610.html](http://www.rubyinside.com/rubys-unary-operators-and-how-to-redefine-their-functionality-5610.html)
* [http://weblog.raganwald.com/2008/06/what-does-do-when-used-as-unary.html](http://weblog.raganwald.com/2008/06/what-does-do-when-used-as-unary.html)
* [https://ruby-doc.org/core-3.0.1/Enumerable.html#method-i-map](https://ruby-doc.org/core-3.0.1/Enumerable.html#method-i-map)