# example5

p %w[hello world].map(&:reverse)
# => ["olleh", "dlrow"]

def greeting(what, *people)
  people.each { |person| puts "#{what}, #{person}" }
  puts
end

greeting 'Hello!', 'Alice"', 'Beth', 'Carl'

# Calling methods:
people = %w[Juan Karla Lucy]
greeting 'Good Evening...', *people

# Array destructuring:
first, *list = [1, 2, 3, 4, 5]
puts "first= #{first}, list= #{list}\n"
puts

*list, last = [1, 2, 3, 4, 5]
puts "list= #{list}, last= #{last}\n"
puts

first, *mid, last = [1, 2, 3, 4, 5]
puts "first= #{first}, mid= #{mid}, last= #{last} \n"
puts

# Array Coercion
array = *'hello', 'world'
puts "array= #{array}\n"
puts

array = *(1..4)
puts "array= #{array}"
