# example3

def splat_method(*arguments)
  arguments.each do |element|
    puts element
  end
  puts
end

arguments = [1, 2, 3, 4]

splat_method(arguments)

# example4
def double_splat_method(**options)
  options.each do |key, value|
    puts "Option #{key}:#{value}"
  end
  puts
end

double_splat_method(first: 'one', second: 'two', third: 'three')
